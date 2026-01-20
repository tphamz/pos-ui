import 'package:dio/dio.dart';
import '../models/auth_models.dart';
import '../services/api_client.dart';
import '../services/entity_service.dart';
import '../utils/password_encryption.dart';

class UserService {
  final ApiClient _apiClient;

  UserService(this._apiClient);

  // Get user by ID
  Future<User> getUser(String userId) async {
    try {
      final response = await _apiClient.dio.get('/users/$userId');
      return User.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get list of users under a business ID
  // Offline-first: pulls from local first, then remote if local is empty
  // Uses EntityService to leverage the repository pattern
  Future<List<Map<String, dynamic>>> getUsersByBusinessId(
    String businessId,
    EntityService entityService,
  ) async {
    // Use EntityService.get() which handles offline-first with auto-pull
    // Staff resource contains users associated with the business
    // EntityService.get() will:
    // 1. Try local first (offline-first)
    // 2. If local is empty, automatically pull from server
    // 3. Return the data from local
    return await entityService.get('staff');
  }

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

  // Assign business role to user (creates user if doesn't exist)
  // Offline-first: saves locally, queues for sync to server
  // The queue will call StaffRemoteRepository.create() which calls assignBusinessRole API
  Future<UserBusinessRole> assignBusinessRole(
    String businessId,
    AssignBusinessRoleRequest request,
    EntityService entityService,
  ) async {
    // Generate local ID for staff member
    final staffId = DateTime.now().millisecondsSinceEpoch.toString();
    
    // Convert request to staff data format
    // Include all fields needed for StaffRemoteRepository.create()
    // which calls /businesses/{id}/users/assign-role API
    final staffData = <String, dynamic>{
      'id': staffId,
      'name': request.fullName,
      'role': request.role,
      'business_id': businessId,
      'email': request.email,
      'phone_number': request.phoneNumber, // Match StaffRemoteRepository.create() field name
      'isActive': true,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };
    
    // Include password if provided (for new user creation)
    // Encrypt password before saving locally
    if (request.password != null && request.password!.isNotEmpty) {
      final encryptedPassword = await PasswordEncryption.encrypt(request.password!);
      staffData['password'] = encryptedPassword;
      staffData['_password_encrypted'] = true; // Flag to indicate password is encrypted
    }
    
    // Save locally via EntityService (saves locally and queues for sync)
    await entityService.save(
      resourceName: 'staff',
      id: staffId,
      data: staffData,
      isCreate: true,
    );
    
    // Return a UserBusinessRole with the local data
    // The actual server response will come later when queue processes
    return UserBusinessRole(
      id: '', // Will be set when queue processes and updates local record
      userId: staffId, // Temporary - will be updated with actual userId from server
      businessId: businessId,
      role: request.role,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
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
