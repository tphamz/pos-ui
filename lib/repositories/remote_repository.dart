import 'package:dio/dio.dart';
import '../services/api_client.dart';

/// Abstract base class for remote API repositories
/// Provides generic CRUD operations for API calls
abstract class RemoteRepository {
  final ApiClient apiClient;
  final String entityType;
  final String basePath; // e.g., '/businesses/{id}/products'
  
  RemoteRepository(this.apiClient, this.entityType, this.basePath);
  
  /// Find one entity by ID
  Future<Map<String, dynamic>?> findOne(String businessId, String id) async {
    try {
      final response = await apiClient.dio.get(
        basePath.replaceAll('{id}', businessId) + '/$id',
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      // Return null if not found (404)
      if (e is DioException && e.response?.statusCode == 404) {
        return null;
      }
      rethrow;
    }
  }
  
  /// Find many entities for a business
  Future<List<Map<String, dynamic>>> findMany(String businessId) async {
    try {
      final response = await apiClient.dio.get(
        basePath.replaceAll('{id}', businessId),
      );
      final List<dynamic> data = response.data;
      return data.map((json) => json as Map<String, dynamic>).toList();
    } catch (e) {
      rethrow;
    }
  }
  
  /// Create a new entity
  Future<Map<String, dynamic>> create(String businessId, Map<String, dynamic> data) async {
    try {
      final response = await apiClient.dio.post(
        basePath.replaceAll('{id}', businessId),
        data: data,
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
  
  /// Update an existing entity
  Future<Map<String, dynamic>> update(String businessId, String id, Map<String, dynamic> data) async {
    try {
      final response = await apiClient.dio.put(
        basePath.replaceAll('{id}', businessId) + '/$id',
        data: data,
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
  
  /// Delete an entity
  Future<void> delete(String businessId, String id) async {
    try {
      await apiClient.dio.delete(
        basePath.replaceAll('{id}', businessId) + '/$id',
      );
    } catch (e) {
      // Ignore 404 (already deleted)
      if (e is DioException && e.response?.statusCode == 404) {
        return;
      }
      rethrow;
    }
  }
  
  /// Generic execute method for action-based operations
  Future<dynamic> execute(String action, Map<String, dynamic> args) {
    final businessId = args['businessId'] as String;
    
    switch (action) {
      case 'findOne':
        return findOne(businessId, args['id'] as String);
      case 'findMany':
        return findMany(businessId);
      case 'create':
        return create(businessId, args['data'] as Map<String, dynamic>);
      case 'update':
        return update(businessId, args['id'] as String, args['data'] as Map<String, dynamic>);
      case 'delete':
        return delete(businessId, args['id'] as String);
      default:
        throw Exception('Unknown action: $action');
    }
  }
}
