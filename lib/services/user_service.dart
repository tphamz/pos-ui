import 'package:dio/dio.dart';
import '../models/auth_models.dart';
import '../services/api_client.dart';

class UserService {
  final ApiClient _apiClient;

  UserService(this._apiClient);

  // Sign up (create user and business) - Public endpoint
  Future<SignUpResponse> signup(SignUpRequest request) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/signup',
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
      
      return SignUpResponse.fromJson(response.data as Map<String, dynamic>);
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
