import 'package:dio/dio.dart';
import '../models/order_models.dart';
import '../services/api_client.dart';

class OrderService {
  final ApiClient _apiClient;

  OrderService(this._apiClient);

  // Get orders for a business
  Future<List<Order>> getOrders(String businessId) async {
    try {
      final response = await _apiClient.dio.get(
        '/businesses/$businessId/orders',
      );
      final List<dynamic> data = response.data;
      return data.map((json) => Order.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get order by ID
  Future<Order> getOrder(String businessId, String orderId) async {
    try {
      final response = await _apiClient.dio.get(
        '/businesses/$businessId/orders/$orderId',
      );
      return Order.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
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
