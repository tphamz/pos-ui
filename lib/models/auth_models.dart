import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

// Request Models
@freezed
class RequestOTPRequest with _$RequestOTPRequest {
  const factory RequestOTPRequest({
    required String contact, // Phone OR Email
    String? storeCode,
  }) = _RequestOTPRequest;

  factory RequestOTPRequest.fromJson(Map<String, dynamic> json) =>
      _$RequestOTPRequestFromJson(json);
}

@freezed
class VerifyOTPRequest with _$VerifyOTPRequest {
  const factory VerifyOTPRequest({
    required String otpToken, // JWT token from RequestOTP response
    required String otpCode, // 6-digit code submitted by user
  }) = _VerifyOTPRequest;

  factory VerifyOTPRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOTPRequestFromJson(json);
}

@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String contact, // Phone OR Email
    required String password,
    String? storeCode,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

@freezed
class LoginTerminalRequest with _$LoginTerminalRequest {
  const factory LoginTerminalRequest({
    required String phone,
    required String storeCode,
    required String pin,
  }) = _LoginTerminalRequest;

  factory LoginTerminalRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginTerminalRequestFromJson(json);
}

@freezed
class CreateUserRequest with _$CreateUserRequest {
  const factory CreateUserRequest({
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'password') String? password,
  }) = _CreateUserRequest;

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateUserRequestFromJson(json);
}

// Response Models
@freezed
class RequestOTPResponse with _$RequestOTPResponse {
  const factory RequestOTPResponse({
    required String otpToken, // Stateless JWT containing hashed code
    required DateTime expiresAt,
    required String message,
  }) = _RequestOTPResponse;

  factory RequestOTPResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestOTPResponseFromJson(json);
}

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required String token,
    String? csrfToken, // Only for web clients
    required String userId,
    required String userType, // "admin" or "staff"
    String? businessId, // For staff type
    String? storeCode, // For staff type
    String? role, // For staff type
    List<BusinessRole>? businesses, // For admin type
    required DateTime expiresAt,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@freezed
class BusinessRole with _$BusinessRole {
  const factory BusinessRole({
    required String businessId,
    required String businessName,
    required String storeCode,
    required String role,
  }) = _BusinessRole;

  factory BusinessRole.fromJson(Map<String, dynamic> json) =>
      _$BusinessRoleFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'is_verified') required bool isVerified,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
}
