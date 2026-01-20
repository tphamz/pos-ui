import 'package:dio/dio.dart';
import 'remote_repository.dart';
import '../services/api_client.dart';
import '../models/order_models.dart';

/// Remote repository for Ticket/Order entities
class TicketRemoteRepository extends RemoteRepository {
  TicketRemoteRepository(ApiClient apiClient) 
      : super(apiClient, 'ticket', '/businesses/{id}/orders');
  
  @override
  Future<List<Map<String, dynamic>>> findMany(String businessId) async {
    try {
      final response = await apiClient.dio.get(
        basePath.replaceAll('{id}', businessId),
      );
      final List<dynamic> data = response.data;
      return data.map((json) {
        // Convert Order model to Map
        final order = Order.fromJson(json as Map<String, dynamic>);
        return order.toJson();
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
      final order = Order.fromJson(response.data as Map<String, dynamic>);
      return order.toJson();
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
      // Map local product IDs to server IDs (should be done by caller)
      final items = (data['items'] as List<dynamic>?) ?? [];
      
      // Backend requires at least 1 item (min=1 validation)
      if (items.isEmpty) {
        throw Exception('Cannot create order: at least one item is required');
      }
      
      final orderItems = items.map((item) {
        return <String, dynamic>{
          'product_id': item['product_id'] ?? item['productId'],
          'product_name': item['product_name'] ?? item['name'],
          'unit_price': item['unit_price'] ?? item['price'],
          'quantity': item['quantity'],
          'tax_rate': item['tax_rate'] ?? 0.0,
          'discount_amount': item['discount_amount'] ?? 
                            ((item['price'] as num?)?.toDouble() ?? 0.0) * 
                            ((item['discount'] as num?)?.toDouble() ?? 0.0) * 
                            (item['quantity'] as int? ?? 1),
        };
      }).toList();
      
      final requestJson = <String, dynamic>{
        'business_id': businessId,
        'items': orderItems,
      };
      
      // Add optional fields
      if (data['table_number'] != null) {
        requestJson['table_number'] = data['table_number'];
      }
      if (data['assignee_id'] != null || data['assigneeId'] != null) {
        requestJson['assignee_id'] = data['assignee_id'] ?? data['assigneeId'];
      }
      
      final response = await apiClient.dio.post(
        basePath.replaceAll('{id}', businessId),
        data: requestJson,
      );
      
      final order = Order.fromJson(response.data as Map<String, dynamic>);
      return order.toJson();
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<Map<String, dynamic>> update(String businessId, String id, Map<String, dynamic> data) async {
    try {
      // For tickets, updates are typically for completing or cancelling
      // Use the server ID (id parameter should be server ID)
      final serverId = data['serverId'] as String? ?? id;
      
      // Check if this is a complete or cancel operation
      final status = data['status'] as String?;
      
      if (status == 'paid' || status == 'completed') {
        // Complete order
        final requestJson = <String, dynamic>{
          'payment_method': data['payment_method'] ?? 'cash',
        };
        
        final response = await apiClient.dio.post(
          basePath.replaceAll('{id}', businessId) + '/$serverId/complete',
          data: requestJson,
        );
        
        final order = Order.fromJson(response.data as Map<String, dynamic>);
        return order.toJson();
      } else if (status == 'cancelled') {
        // Cancel order
        final requestJson = <String, dynamic>{
          'reason': data['reason'] ?? 'Cancelled by user',
        };
        
        final response = await apiClient.dio.post(
          basePath.replaceAll('{id}', businessId) + '/$serverId/cancel',
          data: requestJson,
        );
        
        final order = Order.fromJson(response.data as Map<String, dynamic>);
        return order.toJson();
      } else {
        // Regular update (if supported)
        final requestJson = <String, dynamic>{};
        
        if (data['items'] != null) {
          final items = (data['items'] as List<dynamic>?) ?? [];
          requestJson['items'] = items.map((item) {
            return <String, dynamic>{
              'product_id': item['product_id'] ?? item['productId'],
              'product_name': item['product_name'] ?? item['name'],
              'unit_price': item['unit_price'] ?? item['price'],
              'quantity': item['quantity'],
            };
          }).toList();
        }
        
        // Include version for optimistic locking
        if (data['version'] != null) {
          requestJson['version'] = data['version'];
        }
        
        final response = await apiClient.dio.put(
          basePath.replaceAll('{id}', businessId) + '/$serverId',
          data: requestJson,
        );
        
        final order = Order.fromJson(response.data as Map<String, dynamic>);
        return order.toJson();
      }
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<void> delete(String businessId, String id) async {
    try {
      // Tickets/orders typically shouldn't be deleted
      // Use cancel instead
      throw Exception('Ticket delete not supported - use cancel instead');
    } catch (e) {
      rethrow;
    }
  }
}
