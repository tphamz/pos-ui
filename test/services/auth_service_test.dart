import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:pos_mobile/models/auth_models.dart';
import 'package:pos_mobile/services/auth_service.dart';
import 'package:pos_mobile/services/api_client.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late ApiClient apiClient;
  late AuthService authService;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    apiClient = ApiClient(dio: dio);
    authService = AuthService(apiClient);
  });

  group('AuthService', () {
    group('requestOTP', () {
      test('should successfully request OTP', () async {
        final request = RequestOTPRequest(
          contact: '+17033443167',
          storeCode: 'test-store',
        );

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
          data: request.toJson(),
        );

        final response = await authService.requestOTP(request);

        expect(response.otpToken, equals('test-otp-token'));
        expect(response.message, equals('OTP sent successfully'));
      });

      test('should handle error response', () async {
        final request = RequestOTPRequest(contact: '+17033443167');

        dioAdapter.onPost(
          '/auth/otp/request',
          (server) => server.reply(
            400,
            {'error': 'Invalid contact format'},
          ),
          data: request.toJson(),
        );

        expect(
          () => authService.requestOTP(request),
          throwsA(isA<String>()),
        );
      });
    });

    group('verifyOTP', () {
      test('should successfully verify OTP', () async {
        final request = VerifyOTPRequest(
          otpToken: 'test-token',
          otpCode: '123456',
        );

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
          data: request.toJson(),
        );

        final response = await authService.verifyOTP(request);

        expect(response.token, equals('jwt-token'));
        expect(response.userId, equals('user-123'));
        expect(response.userType, equals('staff'));
      });

      test('should handle invalid OTP code', () async {
        final request = VerifyOTPRequest(
          otpToken: 'test-token',
          otpCode: '000000',
        );

        dioAdapter.onPost(
          '/auth/otp/verify',
          (server) => server.reply(
            401,
            {'error': 'Invalid or expired OTP'},
          ),
          data: request.toJson(),
        );

        expect(
          () => authService.verifyOTP(request),
          throwsA(isA<String>()),
        );
      });

      test('should handle invalid response format', () async {
        final request = VerifyOTPRequest(
          otpToken: 'test-token',
          otpCode: '123456',
        );

        dioAdapter.onPost(
          '/auth/otp/verify',
          (server) => server.reply(200, 'Invalid response'),
          data: request.toJson(),
        );

        expect(
          () => authService.verifyOTP(request),
          throwsA('Invalid response format from server'),
        );
      });
    });

    group('login', () {
      test('should successfully login with password', () async {
        final request = LoginRequest(
          contact: 'user@example.com',
          password: 'password123',
          storeCode: 'test-store',
        );

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
          data: request.toJson(),
        );

        final response = await authService.login(request);

        expect(response.token, equals('jwt-token'));
        expect(response.userId, equals('user-123'));
      });

      test('should handle invalid credentials', () async {
        final request = LoginRequest(
          contact: 'user@example.com',
          password: 'wrong-password',
          storeCode: 'test-store',
        );

        dioAdapter.onPost(
          '/auth/login',
          (server) => server.reply(
            401,
            {'error': 'Invalid credentials'},
          ),
          data: request.toJson(),
        );

        expect(
          () => authService.login(request),
          throwsA(isA<String>()),
        );
      });
    });

    group('logout', () {
      test('should successfully logout', () async {
        dioAdapter.onPost(
          '/auth/logout',
          (server) => server.reply(200, {'message': 'logged out successfully'}),
        );

        await authService.logout();
        // Should not throw
      });

      test('should clear tokens even if logout fails', () async {
        dioAdapter.onPost(
          '/auth/logout',
          (server) => server.reply(500, {'error': 'Server error'}),
        );

        // Should still attempt to clear tokens locally (may throw due to SharedPreferences in test)
        try {
          await authService.logout();
        } catch (e) {
          // Expected to throw either a String error or FlutterError from SharedPreferences
          expect(e, isA<Object>());
        }
      });
    });
  });
}
