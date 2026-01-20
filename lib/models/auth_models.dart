import 'package:freezed_annotation/freezed_annotation.dart';
import 'business_models.dart';

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
    @JsonKey(name: 'otp_token') required String otpToken, // JWT token from RequestOTP response
    @JsonKey(name: 'otp_code') required String otpCode, // 6-digit code submitted by user
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

@freezed
class SignUpRequest with _$SignUpRequest {
  const factory SignUpRequest({
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'password') String? password,
    @JsonKey(name: 'business_name') required String businessName,
    @JsonKey(name: 'blueprint_id') required String blueprintId, // Changed from String? to required String
  }) = _SignUpRequest;

  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);
}

// Response Models
@freezed
class RequestOTPResponse with _$RequestOTPResponse {
  const factory RequestOTPResponse({
    @JsonKey(name: 'otp_token') required String otpToken, // Stateless JWT containing hashed code
    @JsonKey(name: 'expires_at') required DateTime expiresAt,
    required String message,
  }) = _RequestOTPResponse;

  factory RequestOTPResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestOTPResponseFromJson(json);
}

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required String token,
    @JsonKey(name: 'csrf_token') String? csrfToken, // Only for web clients
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'user_type') required String userType, // "admin" or "staff"
    @JsonKey(name: 'business_id') String? businessId, // For staff type
    @JsonKey(name: 'store_code') String? storeCode, // For staff type
    String? role, // For staff type
    List<BusinessRole>? businesses, // For admin type
    @JsonKey(name: 'expires_at') required DateTime expiresAt,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@freezed
class BusinessRole with _$BusinessRole {
  const factory BusinessRole({
    @JsonKey(name: 'business_id') required String businessId,
    @JsonKey(name: 'store_code') required String storeCode,
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
    @Default(1) @JsonKey(name: 'version') int version, // Optimistic locking version
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
}

@freezed
class SignUpResponse with _$SignUpResponse {
  const factory SignUpResponse({
    required User user,
    required Business business,
  }) = _SignUpResponse;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);
}

@freezed
class AssignBusinessRoleRequest with _$AssignBusinessRoleRequest {
  const factory AssignBusinessRoleRequest({
    @JsonKey(name: 'full_name') required String fullName,
    required String email,
    @JsonKey(name: 'phone_number') required String phoneNumber,
    required String role,
    String? password,
    @JsonKey(name: 'terminal_pin') String? terminalPin,
  }) = _AssignBusinessRoleRequest;

  factory AssignBusinessRoleRequest.fromJson(Map<String, dynamic> json) =>
      _$AssignBusinessRoleRequestFromJson(json);
}

@freezed
class UserBusinessRole with _$UserBusinessRole {
  const factory UserBusinessRole({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'business_id') required String businessId,
    required String role,
    @JsonKey(name: 'terminal_pin') String? terminalPin,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _UserBusinessRole;

  factory UserBusinessRole.fromJson(Map<String, dynamic> json) =>
      _$UserBusinessRoleFromJson(json);
}
