import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_client.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../services/business_service.dart';
import '../services/blueprint_service.dart';
import '../services/product_service.dart';
import '../services/order_service.dart';
import '../services/table_service.dart';
import 'entity_providers.dart';

// API Client Provider
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

// Service Providers
final authServiceProvider = Provider<AuthService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthService(apiClient);
});

final userServiceProvider = Provider<UserService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return UserService(apiClient);
});

final businessServiceProvider = Provider<BusinessService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return BusinessService(apiClient);
});

final blueprintServiceProvider = Provider<BlueprintService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return BlueprintService(apiClient);
});

/// ProductService provider (family - takes businessId)
/// Provides typed Product and Category models, delegates to EntityService
final productServiceProvider = Provider.family<ProductService, String>((ref, businessId) {
  final entityService = ref.watch(entityServiceProvider(businessId));
  return ProductService(entityService, businessId);
});

/// OrderService provider
/// Note: Write operations (createOrder, completeOrder, cancelOrder) are handled
/// by TicketRemoteRepository during sync. OrderService is mainly for read operations.
final orderServiceProvider = Provider<OrderService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return OrderService(apiClient);
});

/// TableService provider (family - takes businessId)
/// Provides table management, delegates to EntityService
final tableServiceProvider = Provider.family<TableService, String>((ref, businessId) {
  final entityService = ref.watch(entityServiceProvider(businessId));
  return TableService(entityService, businessId);
});
