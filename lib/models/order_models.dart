import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_models.freezed.dart';
part 'order_models.g.dart';

@freezed
class Order with _$Order {
  const factory Order({
    required String id,
    required String businessId,
    String? createdByUserId,
    String? createdByRoleId,
    required String status, // 'pending', 'completed', 'cancelled'
    required double subtotal,
    required double taxAmount,
    required double totalAmount,
    required double paidAmount,
    Map<String, dynamic>? metadata,
    String? notes,
    required List<OrderItem> items,
    List<Payment>? payments,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) =>
      _$OrderFromJson(json);
}

@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    required String id,
    String? productId,
    required String productName,
    String? productSku,
    required double unitPrice,
    required int quantity,
    required double taxRate,
    required double discountAmount,
    Map<String, dynamic>? modifiers,
    String? notes,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}

@freezed
class Payment with _$Payment {
  const factory Payment({
    required String id,
    required String orderId,
    required String paymentMethod,
    required double amount,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}

@freezed
class CreateOrderRequest with _$CreateOrderRequest {
  const factory CreateOrderRequest({
    required String businessId,
    String? createdByUserId,
    String? createdByRoleId,
    required List<OrderItemRequest> items,
    Map<String, dynamic>? metadata,
    String? notes,
  }) = _CreateOrderRequest;

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestFromJson(json);
}

@freezed
class OrderItemRequest with _$OrderItemRequest {
  const factory OrderItemRequest({
    String? productId,
    required String productName,
    String? productSku,
    required double unitPrice,
    required int quantity,
    @Default(0.0) double taxRate,
    @Default(0.0) double discountAmount,
    Map<String, dynamic>? modifiers,
    String? notes,
  }) = _OrderItemRequest;

  factory OrderItemRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderItemRequestFromJson(json);
}

@freezed
class CompleteOrderRequest with _$CompleteOrderRequest {
  const factory CompleteOrderRequest({
    required List<PaymentRequest> payments,
  }) = _CompleteOrderRequest;

  factory CompleteOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CompleteOrderRequestFromJson(json);
}

@freezed
class PaymentRequest with _$PaymentRequest {
  const factory PaymentRequest({
    required String paymentMethod,
    required double amount,
    Map<String, dynamic>? metadata,
  }) = _PaymentRequest;

  factory PaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentRequestFromJson(json);
}

@freezed
class CancelOrderRequest with _$CancelOrderRequest {
  const factory CancelOrderRequest({
    String? reason,
    @Default(false) bool restoreStock,
  }) = _CancelOrderRequest;

  factory CancelOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CancelOrderRequestFromJson(json);
}
