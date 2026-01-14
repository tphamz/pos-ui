import 'package:dio/dio.dart';
import '../models/auth_models.dart';
import '../services/api_client.dart';

class UserService {
  final ApiClient _apiClient;

  UserService(this._apiClient);

  // Sign up (create user)
  // Note: This endpoint requires authentication and permissions
  // For public signup, you'd need a separate public endpoint
  Future<User> signup(CreateUserRequest request) async {
    try {
      final response = await _apiClient.dio.post(
        '/users',
        data: request.toJson(),
      );
      return User.fromJson(response.data);
    } on DioException catch (e) {
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
