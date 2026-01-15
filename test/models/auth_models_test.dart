import 'package:flutter_test/flutter_test.dart';
import 'package:pos_mobile/models/auth_models.dart';
import 'package:pos_mobile/models/business_models.dart';

void main() {
  group('Auth Models', () {
    group('RequestOTPRequest', () {
      test('should serialize to JSON correctly', () {
        final request = RequestOTPRequest(
          contact: '+17033443167',
          storeCode: 'test-store',
        );

        final json = request.toJson();
        expect(json['contact'], equals('+17033443167'));
        expect(json['storeCode'], equals('test-store'));
      });

      test('should deserialize from JSON correctly', () {
        final json = {
          'contact': '+17033443167',
          'storeCode': 'test-store',
        };

        final request = RequestOTPRequest.fromJson(json);
        expect(request.contact, equals('+17033443167'));
        expect(request.storeCode, equals('test-store'));
      });

      test('should handle null storeCode', () {
        final request = RequestOTPRequest(contact: '+17033443167');
        final json = request.toJson();
        expect(json['storeCode'], isNull);
      });
    });

    group('VerifyOTPRequest', () {
      test('should serialize to JSON with snake_case keys', () {
        final request = VerifyOTPRequest(
          otpToken: 'token123',
          otpCode: '123456',
        );

        final json = request.toJson();
        expect(json['otp_token'], equals('token123'));
        expect(json['otp_code'], equals('123456'));
      });

      test('should deserialize from JSON with snake_case keys', () {
        final json = {
          'otp_token': 'token123',
          'otp_code': '123456',
        };

        final request = VerifyOTPRequest.fromJson(json);
        expect(request.otpToken, equals('token123'));
        expect(request.otpCode, equals('123456'));
      });
    });

    group('LoginRequest', () {
      test('should serialize to JSON correctly', () {
        final request = LoginRequest(
          contact: 'user@example.com',
          password: 'password123',
          storeCode: 'test-store',
        );

        final json = request.toJson();
        expect(json['contact'], equals('user@example.com'));
        expect(json['password'], equals('password123'));
        expect(json['storeCode'], equals('test-store'));
      });

      test('should deserialize from JSON correctly', () {
        final json = {
          'contact': 'user@example.com',
          'password': 'password123',
          'storeCode': 'test-store',
        };

        final request = LoginRequest.fromJson(json);
        expect(request.contact, equals('user@example.com'));
        expect(request.password, equals('password123'));
        expect(request.storeCode, equals('test-store'));
      });
    });

    group('SignUpRequest', () {
      test('should serialize to JSON with snake_case keys', () {
        final request = SignUpRequest(
          fullName: 'John Doe',
          businessName: 'My Business',
          email: 'john@example.com',
          phoneNumber: '+17033443167',
          password: 'password123',
        );

        final json = request.toJson();
        expect(json['full_name'], equals('John Doe'));
        expect(json['business_name'], equals('My Business'));
        expect(json['email'], equals('john@example.com'));
        expect(json['phone_number'], equals('+17033443167'));
        expect(json['password'], equals('password123'));
      });

      test('should deserialize from JSON with snake_case keys', () {
        final json = {
          'full_name': 'John Doe',
          'business_name': 'My Business',
          'email': 'john@example.com',
          'phone_number': '+17033443167',
        };

        final request = SignUpRequest.fromJson(json);
        expect(request.fullName, equals('John Doe'));
        expect(request.businessName, equals('My Business'));
        expect(request.email, equals('john@example.com'));
        expect(request.phoneNumber, equals('+17033443167'));
      });
    });

    group('LoginResponse', () {
      test('should deserialize from JSON with snake_case keys', () {
        final json = {
          'token': 'jwt-token',
          'csrf_token': 'csrf-token',
          'user_id': 'user-123',
          'user_type': 'staff',
          'business_id': 'business-123',
          'store_code': 'test-store',
          'role': 'cashier',
          'expires_at': '2024-01-01T00:00:00Z',
        };

        final response = LoginResponse.fromJson(json);
        expect(response.token, equals('jwt-token'));
        expect(response.csrfToken, equals('csrf-token'));
        expect(response.userId, equals('user-123'));
        expect(response.userType, equals('staff'));
        expect(response.businessId, equals('business-123'));
        expect(response.storeCode, equals('test-store'));
        expect(response.role, equals('cashier'));
      });

      test('should handle admin login response with businesses', () {
        final json = {
          'token': 'jwt-token',
          'user_id': 'user-123',
          'user_type': 'admin',
          'businesses': [
            {
              'business_id': 'biz-1',
              'store_code': 'store-1',
              'role': 'owner',
            },
            {
              'business_id': 'biz-2',
              'store_code': 'store-2',
              'role': 'manager',
            },
          ],
          'expires_at': '2024-01-01T00:00:00Z',
        };

        final response = LoginResponse.fromJson(json);
        expect(response.userType, equals('admin'));
        expect(response.businesses, isNotNull);
        expect(response.businesses!.length, equals(2));
        expect(response.businesses![0].businessId, equals('biz-1'));
        expect(response.businesses![0].storeCode, equals('store-1'));
      });

      test('should handle null optional fields', () {
        final json = {
          'token': 'jwt-token',
          'user_id': 'user-123',
          'user_type': 'staff',
          'expires_at': '2024-01-01T00:00:00Z',
        };

        final response = LoginResponse.fromJson(json);
        expect(response.csrfToken, isNull);
        expect(response.businessId, isNull);
        expect(response.storeCode, isNull);
        expect(response.role, isNull);
      });
    });

    group('SignUpResponse', () {
      test('should deserialize from JSON correctly', () {
        final json = {
          'user': {
            'id': 'user-123',
            'full_name': 'John Doe',
            'email': 'john@example.com',
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
        };

        final response = SignUpResponse.fromJson(json);
        expect(response.user.fullName, equals('John Doe'));
        expect(response.business.name, equals('My Business'));
        expect(response.business.storeCode, equals('my-business'));
      });
    });

    group('BusinessRole', () {
      test('should deserialize from JSON with snake_case keys', () {
        final json = {
          'business_id': 'biz-123',
          'store_code': 'test-store',
          'role': 'cashier',
        };

        final role = BusinessRole.fromJson(json);
        expect(role.businessId, equals('biz-123'));
        expect(role.storeCode, equals('test-store'));
        expect(role.role, equals('cashier'));
      });
    });

    group('User', () {
      test('should deserialize from JSON with snake_case keys', () {
        final json = {
          'id': 'user-123',
          'full_name': 'John Doe',
          'phone_number': '+17033443167',
          'email': 'john@example.com',
          'is_verified': true,
          'created_at': '2024-01-01T00:00:00Z',
        };

        final user = User.fromJson(json);
        expect(user.id, equals('user-123'));
        expect(user.fullName, equals('John Doe'));
        expect(user.phoneNumber, equals('+17033443167'));
        expect(user.email, equals('john@example.com'));
        expect(user.isVerified, isTrue);
      });
    });
  });
}
