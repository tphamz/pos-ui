import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:pos_mobile/models/auth_models.dart';
import 'package:pos_mobile/providers/auth_provider.dart';
import 'package:pos_mobile/providers/api_providers.dart';
import 'package:pos_mobile/services/auth_service.dart';
import 'package:pos_mobile/services/api_client.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late ApiClient apiClient;
  late AuthService authService;
  late ProviderContainer container;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    apiClient = ApiClient(dio: dio);
    authService = AuthService(apiClient);
    container = ProviderContainer(
      overrides: [
        authServiceProvider.overrideWithValue(authService),
        apiClientProvider.overrideWithValue(apiClient),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('AuthProvider', () {
    test('initial state should be unauthenticated', () {
      final authState = container.read(authProvider);
      expect(authState.isAuthenticated, isFalse);
      expect(authState.user, isNull);
      expect(authState.isLoading, isFalse);
      expect(authState.error, isNull);
    });

    group('requestOTP', () {
      test('should successfully request OTP', () async {
        dioAdapter.onPost(
          '/auth/otp/request',
          (server) => server.reply(
            200,
            {
              'otp_token': 'test-otp-token',
              'expires_at': '2024-01-01T00:02:00Z',
              'message': 'OTP sent successfully',
            },
          ),
        );

        final notifier = container.read(authProvider.notifier);
        final otpToken = await notifier.requestOTP('+17033443167', storeCode: 'test-store');

        expect(otpToken, equals('test-otp-token'));

        final state = container.read(authProvider);
        expect(state.isLoading, isFalse);
        expect(state.error, isNull);
      });

      test('should handle error when requesting OTP', () async {
        dioAdapter.onPost(
          '/auth/otp/request',
          (server) => server.reply(
            400,
            {'error': 'Invalid contact format'},
          ),
        );

        final notifier = container.read(authProvider.notifier);
        
        expect(
          () => notifier.requestOTP('invalid'),
          throwsA(isA<String>()),
        );

        final state = container.read(authProvider);
        expect(state.isLoading, isFalse);
        expect(state.error, isNotNull);
      });
    });

    group('verifyOTP', () {
      test('should successfully verify OTP and update state', () async {
        dioAdapter.onPost(
          '/auth/otp/verify',
          (server) => server.reply(
            200,
            {
              'token': 'jwt-token',
              'user_id': 'user-123',
              'user_type': 'staff',
              'business_id': 'business-123',
              'store_code': 'test-store',
              'role': 'cashier',
              'expires_at': '2024-01-01T00:00:00Z',
            },
          ),
        );

        final notifier = container.read(authProvider.notifier);
        await notifier.verifyOTP('test-token', '123456');

        final state = container.read(authProvider);
        expect(state.isAuthenticated, isTrue);
        expect(state.user, isNotNull);
        expect(state.user?.token, equals('jwt-token'));
        expect(state.user?.userId, equals('user-123'));
        expect(state.isLoading, isFalse);
        expect(state.error, isNull);
      });

      test('should handle error when verifying OTP', () async {
        dioAdapter.onPost(
          '/auth/otp/verify',
          (server) => server.reply(
            401,
            {'error': 'Invalid or expired OTP'},
          ),
        );

        final notifier = container.read(authProvider.notifier);
        
        expect(
          () => notifier.verifyOTP('test-token', '000000'),
          throwsA(isA<String>()),
        );

        final state = container.read(authProvider);
        expect(state.isAuthenticated, isFalse);
        expect(state.isLoading, isFalse);
        expect(state.error, isNotNull);
      });
    });

    group('login', () {
      test('should successfully login and update state', () async {
        dioAdapter.onPost(
          '/auth/login',
          (server) => server.reply(
            200,
            {
              'token': 'jwt-token',
              'user_id': 'user-123',
              'user_type': 'staff',
              'business_id': 'business-123',
              'store_code': 'test-store',
              'role': 'cashier',
              'expires_at': '2024-01-01T00:00:00Z',
            },
          ),
        );

        final notifier = container.read(authProvider.notifier);
        await notifier.login('user@example.com', 'password123', storeCode: 'test-store');

        final state = container.read(authProvider);
        expect(state.isAuthenticated, isTrue);
        expect(state.user, isNotNull);
        expect(state.user?.token, equals('jwt-token'));
        expect(state.isLoading, isFalse);
        expect(state.error, isNull);
      });

      test('should handle invalid credentials', () async {
        dioAdapter.onPost(
          '/auth/login',
          (server) => server.reply(
            401,
            {'error': 'Invalid credentials'},
          ),
        );

        final notifier = container.read(authProvider.notifier);
        
        expect(
          () => notifier.login('user@example.com', 'wrong-password', storeCode: 'test-store'),
          throwsA(isA<String>()),
        );

        final state = container.read(authProvider);
        expect(state.isAuthenticated, isFalse);
        expect(state.isLoading, isFalse);
        expect(state.error, isNotNull);
      });
    });

    group('logout', () {
      test('should successfully logout and clear state', () async {
        // First login
        dioAdapter.onPost(
          '/auth/login',
          (server) => server.reply(
            200,
            {
              'token': 'jwt-token',
              'user_id': 'user-123',
              'user_type': 'staff',
              'expires_at': '2024-01-01T00:00:00Z',
            },
          ),
        );

        final notifier = container.read(authProvider.notifier);
        await notifier.login('user@example.com', 'password123', storeCode: 'test-store');
        
        expect(container.read(authProvider).isAuthenticated, isTrue);

        // Then logout
        dioAdapter.onPost(
          '/auth/logout',
          (server) => server.reply(200, {'message': 'logged out successfully'}),
        );

        await notifier.logout();

        final state = container.read(authProvider);
        expect(state.isAuthenticated, isFalse);
        expect(state.user, isNull);
        expect(state.isLoading, isFalse);
      });
    });
  });
}
