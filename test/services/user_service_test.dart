import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:pos_mobile/models/auth_models.dart';
import 'package:pos_mobile/services/user_service.dart';
import 'package:pos_mobile/services/api_client.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late ApiClient apiClient;
  late UserService userService;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    apiClient = ApiClient(dio: dio);
    userService = UserService(apiClient);
  });

  group('UserService', () {
    group('signup', () {
      test('should successfully sign up user and business', () async {
        final request = SignUpRequest(
          fullName: 'John Doe',
          businessName: 'My Business',
          email: 'john@example.com',
          phoneNumber: '+17033443167',
          password: 'password123',
        );

        dioAdapter.onPost(
          '/auth/signup',
          (server) => server.reply(
            201,
            {
              'user': {
                'id': 'user-123',
                'full_name': 'John Doe',
                'email': 'john@example.com',
                'phone_number': '+17033443167',
                'is_verified': false,
                'created_at': '2024-01-01T00:00:00Z',
              },
              'business': {
                'id': 'business-123',
                'name': 'My Business',
                'store_code': 'my-business',
                'currency': 'USD',
                'timezone': 'America/New_York',
                'status': 'active',
                'created_at': '2024-01-01T00:00:00Z',
                'updated_at': '2024-01-01T00:00:00Z',
              },
            },
          ),
          data: request.toJson(),
        );

        final response = await userService.signup(request);

        expect(response.user.fullName, equals('John Doe'));
        expect(response.business.name, equals('My Business'));
        expect(response.business.storeCode, equals('my-business'));
      });

      test('should handle signup with only email', () async {
        final request = SignUpRequest(
          fullName: 'Jane Doe',
          businessName: 'Jane\'s Business',
          email: 'jane@example.com',
        );

        dioAdapter.onPost(
          '/auth/signup',
          (server) => server.reply(
            201,
            {
              'user': {
                'id': 'user-456',
                'full_name': 'Jane Doe',
                'email': 'jane@example.com',
                'is_verified': false,
                'created_at': '2024-01-01T00:00:00Z',
              },
              'business': {
                'id': 'business-456',
                'name': 'Jane\'s Business',
                'store_code': 'janes-business',
                'currency': 'USD',
                'timezone': 'America/New_York',
                'status': 'active',
                'created_at': '2024-01-01T00:00:00Z',
                'updated_at': '2024-01-01T00:00:00Z',
              },
            },
          ),
          data: request.toJson(),
        );

        final response = await userService.signup(request);
        expect(response.user.email, equals('jane@example.com'));
        expect(response.user.phoneNumber, isNull);
      });

      test('should handle signup with only phone number', () async {
        final request = SignUpRequest(
          fullName: 'Bob Smith',
          businessName: 'Bob\'s Store',
          phoneNumber: '+17033443167',
        );

        dioAdapter.onPost(
          '/auth/signup',
          (server) => server.reply(
            201,
            {
              'user': {
                'id': 'user-789',
                'full_name': 'Bob Smith',
                'phone_number': '+17033443167',
                'is_verified': false,
                'created_at': '2024-01-01T00:00:00Z',
              },
              'business': {
                'id': 'business-789',
                'name': 'Bob\'s Store',
                'store_code': 'bobs-store',
                'currency': 'USD',
                'timezone': 'America/New_York',
                'status': 'active',
                'created_at': '2024-01-01T00:00:00Z',
                'updated_at': '2024-01-01T00:00:00Z',
              },
            },
          ),
          data: request.toJson(),
        );

        final response = await userService.signup(request);
        expect(response.user.phoneNumber, equals('+17033443167'));
        expect(response.user.email, isNull);
      });

      test('should handle duplicate email error', () async {
        final request = SignUpRequest(
          fullName: 'John Doe',
          businessName: 'My Business',
          email: 'existing@example.com',
        );

        dioAdapter.onPost(
          '/auth/signup',
          (server) => server.reply(
            400,
            {'error': 'user with email existing@example.com already exists'},
          ),
          data: request.toJson(),
        );

        expect(
          () => userService.signup(request),
          throwsA(contains('already exists')),
        );
      });

      test('should handle invalid response format', () async {
        final request = SignUpRequest(
          fullName: 'John Doe',
          businessName: 'My Business',
          email: 'john@example.com',
        );

        dioAdapter.onPost(
          '/auth/signup',
          (server) => server.reply(200, 'Invalid response'),
          data: request.toJson(),
        );

        expect(
          () => userService.signup(request),
          throwsA('Invalid response format from server'),
        );
      });
    });
  });
}
