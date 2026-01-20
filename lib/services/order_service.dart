import 'package:dio/dio.dart';
import '../models/order_models.dart';
import '../services/api_client.dart';
import '../services/entity_service.dart';

/// Service for Order operations
/// Note: Orders and Tickets are the same entity (tickets are draft orders)
/// Read operations use EntityService for offline-first behavior
/// Write operations are handled by TicketRemoteRepository during sync
class OrderService {
  final ApiClient _apiClient;

  OrderService(this._apiClient);

  // Get orders for a business (read-only, for viewing order history)
  // Offline-first: pulls from local first, then remote if local is empty
  // Uses EntityService to leverage the repository pattern
  // Note: Tickets and Orders are the same entity - this gets all tickets/orders
  Future<List<Order>> getOrders(
    String businessId,
    EntityService entityService, {
    String? status, // Optional: filter by status (e.g., 'completed', 'cancelled')
  }) async {
    // Use EntityService.get() which handles offline-first with auto-pull
    // Tickets/orders are stored in the 'ticket' resource
    final ticketsData = await entityService.get('ticket');
    
    // Convert to Order models
    final orders = ticketsData
        .map((data) {
          try {
            return Order.fromJson(data);
          } catch (e) {
            return null;
          }
        })
        .whereType<Order>()
        .toList();
    
    // Filter by status if provided
    if (status != null) {
      return orders.where((order) => order.status == status).toList();
    }
    
    return orders;
  }

  // Get order by ID (read-only, for viewing order history)
  // Offline-first: pulls from local first, then remote if not found locally
  // Uses EntityService to leverage the repository pattern
  Future<Order?> getOrder(
    String businessId,
    String orderId,
    EntityService entityService,
  ) async {
    // Use EntityService.getOne() which handles offline-first with auto-pull
    final ticketData = await entityService.getOne('ticket', orderId);
    
    if (ticketData == null) return null;
    
    try {
      return Order.fromJson(ticketData);
    } catch (e) {
      return null;
    }
  }

  // Create order
  Future<Order> createOrder(
    String businessId,
    CreateOrderRequest request,
  ) async {
    try {
      final response = await _apiClient.dio.post(
        '/businesses/$businessId/orders',
        data: request.toJson(),
      );
      return Order.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Complete order
  Future<Order> completeOrder(
    String businessId,
    String orderId,
    CompleteOrderRequest request,
  ) async {
    try {
      final response = await _apiClient.dio.post(
        '/businesses/$businessId/orders/$orderId/complete',
        data: request.toJson(),
      );
      return Order.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Cancel order
  Future<Order> cancelOrder(
    String businessId,
    String orderId,
    CancelOrderRequest request,
  ) async {
    try {
      final response = await _apiClient.dio.post(
        '/businesses/$businessId/orders/$orderId/cancel',
        data: request.toJson(),
      );
      return Order.fromJson(response.data);
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
