import 'package:dio/dio.dart';
import 'remote_repository.dart';
import '../services/api_client.dart';
import '../utils/password_encryption.dart';

/// Remote repository for Staff entities
/// Note: Staff API endpoints may not be fully implemented yet on backend
/// This repository is ready for when endpoints are available
class StaffRemoteRepository extends RemoteRepository {
  StaffRemoteRepository(ApiClient apiClient) 
      : super(apiClient, 'staff', '/businesses/{id}/staff');
  
  @override
  Future<List<Map<String, dynamic>>> findMany(String businessId) async {
    try {
      // TODO: Update endpoint when staff API is available
      // For now, staff might be fetched via users endpoint
      // GET /businesses/{id}/users
      final response = await apiClient.dio.get(
        '/businesses/$businessId/users',
      );
      final List<dynamic> data = response.data;
      return data.map((json) => json as Map<String, dynamic>).toList();
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<Map<String, dynamic>?> findOne(String businessId, String id) async {
    try {
      // TODO: Update endpoint when staff API is available
      final response = await apiClient.dio.get(
        '/users/$id',
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 404) {
        return null;
      }
      rethrow;
    }
  }
  
  @override
  Future<Map<String, dynamic>> create(String businessId, Map<String, dynamic> data) async {
    try {
      // Staff creation via user assignment endpoint
      // POST /businesses/{id}/users/assign-role
      // Backend expects: full_name, email, phone_number, role (all required)
      // Optional: password, terminal_pin
      
      // Get full_name from either 'name' or 'full_name' field (we store as 'name' locally)
      final fullName = data['full_name'] as String? ?? data['name'] as String? ?? '';
      if (fullName.isEmpty) {
        throw Exception('full_name is required but was not provided');
      }
      
      final requestJson = <String, dynamic>{
        'full_name': fullName, // Backend requires 'full_name' (not 'name')
        'email': data['email'] as String? ?? '',
        'phone_number': data['phone_number'] as String? ?? '',
        'role': data['role'] as String? ?? 'staff',
      };
      
      // Validate required fields
      if ((requestJson['email'] as String).isEmpty) {
        throw Exception('email is required but was not provided');
      }
      if ((requestJson['phone_number'] as String).isEmpty) {
        throw Exception('phone_number is required but was not provided');
      }
      
      // Decrypt password if it's encrypted before sending to server
      if (data['password'] != null) {
        final isEncrypted = data['_password_encrypted'] == true;
        if (isEncrypted) {
          // Decrypt password before sending to server
          final decryptedPassword = await PasswordEncryption.decrypt(data['password'] as String);
          requestJson['password'] = decryptedPassword;
        } else {
          // Password is already plain text (shouldn't happen, but handle it)
          requestJson['password'] = data['password'];
        }
      }
      
      // Add terminal_pin if provided
      if (data['terminal_pin'] != null) {
        requestJson['terminal_pin'] = data['terminal_pin'];
      }
      
      final response = await apiClient.dio.post(
        '/businesses/$businessId/users/assign-role',
        data: requestJson,
      );
      
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<Map<String, dynamic>> update(String businessId, String id, Map<String, dynamic> data) async {
    try {
      // TODO: Update endpoint when staff API is available
      // For now, staff update might be via user update
      // PUT /users/{id}
      final requestJson = <String, dynamic>{};
      
      if (data['name'] != null) {
        requestJson['name'] = data['name'];
      }
      if (data['role'] != null) {
        requestJson['role'] = data['role'];
      }
      
      // Include version for optimistic locking
      if (data['version'] != null) {
        requestJson['version'] = data['version'];
      }
      
      final response = await apiClient.dio.put(
        '/users/$id',
        data: requestJson,
      );
      
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<void> delete(String businessId, String id) async {
    try {
      // TODO: Update endpoint when staff API is available
      // For now, staff deletion might be via user removal
      // DELETE /businesses/{id}/users/{user_id}
      await apiClient.dio.delete(
        '/businesses/$businessId/users/$id',
      );
    } catch (e) {
      // Ignore 404 (already deleted)
      if (e is DioException && e.response?.statusCode == 404) {
        return;
      }
      rethrow;
    }
  }
}
