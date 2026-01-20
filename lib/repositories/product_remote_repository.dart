import 'package:dio/dio.dart';
import 'remote_repository.dart';
import '../services/api_client.dart';
import '../models/product_models.dart';

/// Remote repository for Product entities
class ProductRemoteRepository extends RemoteRepository {
  ProductRemoteRepository(ApiClient apiClient) 
      : super(apiClient, 'product', '/businesses/{id}/products');
  
  @override
  Future<List<Map<String, dynamic>>> findMany(String businessId) async {
    try {
      final response = await apiClient.dio.get(
        basePath.replaceAll('{id}', businessId),
      );
      final List<dynamic> data = response.data;
      return data.map((json) {
        // Convert Product model to Map
        final product = Product.fromJson(json as Map<String, dynamic>);
        return product.toJson();
      }).toList();
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<Map<String, dynamic>?> findOne(String businessId, String id) async {
    try {
      final response = await apiClient.dio.get(
        basePath.replaceAll('{id}', businessId) + '/$id',
      );
      final product = Product.fromJson(response.data as Map<String, dynamic>);
      return product.toJson();
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
      // Build request with snake_case keys (backend expects this)
      final requestJson = <String, dynamic>{
        'business_id': businessId,
        'name': data['name'] as String? ?? '',
        'base_price': data['base_price'] ?? data['price'] ?? 0.0,
        'tax_rate': data['tax_rate'] ?? 0.0,
        'is_active': data['is_active'] ?? true,
        'stock_quantity': data['stock_quantity'] ?? 0,
      };
      
      // Add optional fields
      if (data['category'] != null || data['categoryId'] != null) {
        requestJson['category'] = data['category'] ?? data['categoryId'];
      }
      if (data['sku'] != null) {
        requestJson['sku'] = data['sku'];
      }
      if (data['metadata'] != null) {
        requestJson['metadata'] = data['metadata'];
      }
      
      final response = await apiClient.dio.post(
        basePath.replaceAll('{id}', businessId),
        data: requestJson,
      );
      
      final product = Product.fromJson(response.data as Map<String, dynamic>);
      return product.toJson();
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<Map<String, dynamic>> update(String businessId, String id, Map<String, dynamic> data) async {
    try {
      // Get the server ID (id parameter is local ID, need server ID for update)
      // This should be handled by the caller, but we'll use id as fallback
      final serverId = data['serverId'] as String? ?? id;
      
      // Build request with snake_case keys
      final requestJson = <String, dynamic>{
        'name': data['name'] as String? ?? '',
        'base_price': data['base_price'] ?? data['price'] ?? 0.0,
        'tax_rate': data['tax_rate'] ?? 0.0,
        'is_active': data['is_active'] ?? true,
        'stock_quantity': data['stock_quantity'] ?? 0,
      };
      
      // Add optional fields
      if (data['category'] != null || data['categoryId'] != null) {
        requestJson['category'] = data['category'] ?? data['categoryId'];
      }
      if (data['sku'] != null) {
        requestJson['sku'] = data['sku'];
      }
      if (data['metadata'] != null) {
        requestJson['metadata'] = data['metadata'];
      }
      
      // Include version for optimistic locking
      if (data['version'] != null) {
        requestJson['version'] = data['version'];
      }
      
      final response = await apiClient.dio.put(
        basePath.replaceAll('{id}', businessId) + '/$serverId',
        data: requestJson,
      );
      
      final product = Product.fromJson(response.data as Map<String, dynamic>);
      return product.toJson();
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<void> delete(String businessId, String id) async {
    try {
      // id parameter should be server ID for delete
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
}
