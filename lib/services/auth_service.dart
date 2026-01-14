import 'package:dio/dio.dart';
import '../models/auth_models.dart';
import '../services/api_client.dart';

class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

  // Request OTP code
  Future<RequestOTPResponse> requestOTP(RequestOTPRequest request) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/otp/request',
        data: request.toJson(),
      );
      return RequestOTPResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Verify OTP code
  Future<LoginResponse> verifyOTP(VerifyOTPRequest request) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/otp/verify',
        data: request.toJson(),
      );
      final loginResponse = LoginResponse.fromJson(response.data);
      
      // Store the auth token
      if (loginResponse.token.isNotEmpty) {
        await _apiClient.setAuthToken(loginResponse.token);
      }
      
      return loginResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Login with password
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/login',
        data: request.toJson(),
      );
      final loginResponse = LoginResponse.fromJson(response.data);
      
      // Store the auth token
      if (loginResponse.token.isNotEmpty) {
        await _apiClient.setAuthToken(loginResponse.token);
      }
      
      return loginResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Terminal login with PIN
  Future<LoginResponse> loginTerminal(LoginTerminalRequest request) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/login/terminal',
        data: request.toJson(),
      );
      final loginResponse = LoginResponse.fromJson(response.data);
      
      // Store the auth token
      if (loginResponse.token.isNotEmpty) {
        await _apiClient.setAuthToken(loginResponse.token);
      }
      
      return loginResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _apiClient.dio.post('/auth/logout');
      await _apiClient.clearTokens();
    } on DioException catch (e) {
      // Even if logout fails, clear local tokens
      await _apiClient.clearTokens();
      throw _handleError(e);
    }
  }

  String _handleError(DioException error) {
    if (error.response != null) {
      final data = error.response!.data;
      if (data is Map<String, dynamic>) {
        return data['message'] as String? ?? 
               data['error'] as String? ?? 
               'An error occurred';
      }
    }
    return error.error?.toString() ?? 'An error occurred';
  }
}
