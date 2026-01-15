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
      
      // Check if response is successful
      if (response.statusCode != null && response.statusCode! >= 400) {
        throw _handleError(DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        ));
      }
      
      // Validate response data is a Map
      if (response.data is! Map<String, dynamic>) {
        throw 'Invalid response format from server';
      }
      
      return RequestOTPResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      // Handle non-DioException errors (like type cast errors)
      if (e is TypeError) {
        throw 'Invalid response format from server. Please try again.';
      }
      rethrow;
    }
  }

  // Verify OTP code
  Future<LoginResponse> verifyOTP(VerifyOTPRequest request) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/otp/verify',
        data: request.toJson(),
      );
      
      // Check if response is successful
      if (response.statusCode != null && response.statusCode! >= 400) {
        throw _handleError(DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        ));
      }
      
      // Validate response data is a Map
      if (response.data is! Map<String, dynamic>) {
        throw 'Invalid response format from server';
      }
      
      final loginResponse = LoginResponse.fromJson(response.data as Map<String, dynamic>);
      
      // Store the auth token
      if (loginResponse.token.isNotEmpty) {
        await _apiClient.setAuthToken(loginResponse.token);
      }
      
      return loginResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      // Handle non-DioException errors (like type cast errors)
      if (e is TypeError) {
        throw 'Invalid response format from server. Please try again.';
      }
      rethrow;
    }
  }

  // Login with password
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/login',
        data: request.toJson(),
      );
      
      // Check if response is successful
      if (response.statusCode != null && response.statusCode! >= 400) {
        throw _handleError(DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        ));
      }
      
      // Validate response data is a Map
      if (response.data is! Map<String, dynamic>) {
        throw 'Invalid response format from server';
      }
      
      final loginResponse = LoginResponse.fromJson(response.data as Map<String, dynamic>);
      
      // Store the auth token
      if (loginResponse.token.isNotEmpty) {
        await _apiClient.setAuthToken(loginResponse.token);
      }
      
      return loginResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      // Handle non-DioException errors (like type cast errors)
      if (e is TypeError) {
        throw 'Invalid response format from server. Please try again.';
      }
      rethrow;
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
