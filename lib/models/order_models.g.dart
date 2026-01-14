// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
  id: json['id'] as String,
  businessId: json['businessId'] as String,
  createdByUserId: json['createdByUserId'] as String?,
  createdByRoleId: json['createdByRoleId'] as String?,
  status: json['status'] as String,
  subtotal: (json['subtotal'] as num).toDouble(),
  taxAmount: (json['taxAmount'] as num).toDouble(),
  totalAmount: (json['totalAmount'] as num).toDouble(),
  paidAmount: (json['paidAmount'] as num).toDouble(),
  metadata: json['metadata'] as Map<String, dynamic>?,
  notes: json['notes'] as String?,
  items: (json['items'] as List<dynamic>)
      .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  payments: (json['payments'] as List<dynamic>?)
      ?.map((e) => Payment.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
);

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'businessId': instance.businessId,
      'createdByUserId': instance.createdByUserId,
      'createdByRoleId': instance.createdByRoleId,
      'status': instance.status,
      'subtotal': instance.subtotal,
      'taxAmount': instance.taxAmount,
      'totalAmount': instance.totalAmount,
      'paidAmount': instance.paidAmount,
      'metadata': instance.metadata,
      'notes': instance.notes,
      'items': instance.items,
      'payments': instance.payments,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };

_$OrderItemImpl _$$OrderItemImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemImpl(
      id: json['id'] as String,
      productId: json['productId'] as String?,
      productName: json['productName'] as String,
      productSku: json['productSku'] as String?,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      taxRate: (json['taxRate'] as num).toDouble(),
      discountAmount: (json['discountAmount'] as num).toDouble(),
      modifiers: json['modifiers'] as Map<String, dynamic>?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$OrderItemImplToJson(_$OrderItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'productName': instance.productName,
      'productSku': instance.productSku,
      'unitPrice': instance.unitPrice,
      'quantity': instance.quantity,
      'taxRate': instance.taxRate,
      'discountAmount': instance.discountAmount,
      'modifiers': instance.modifiers,
      'notes': instance.notes,
    };

_$PaymentImpl _$$PaymentImplFromJson(Map<String, dynamic> json) =>
    _$PaymentImpl(
      id: json['id'] as String,
      orderId: json['orderId'] as String,
      paymentMethod: json['paymentMethod'] as String,
      amount: (json['amount'] as num).toDouble(),
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$PaymentImplToJson(_$PaymentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'paymentMethod': instance.paymentMethod,
      'amount': instance.amount,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$CreateOrderRequestImpl _$$CreateOrderRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateOrderRequestImpl(
  businessId: json['businessId'] as String,
  createdByUserId: json['createdByUserId'] as String?,
  createdByRoleId: json['createdByRoleId'] as String?,
  items: (json['items'] as List<dynamic>)
      .map((e) => OrderItemRequest.fromJson(e as Map<String, dynamic>))
      .toList(),
  metadata: json['metadata'] as Map<String, dynamic>?,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$$CreateOrderRequestImplToJson(
  _$CreateOrderRequestImpl instance,
) => <String, dynamic>{
  'businessId': instance.businessId,
  'createdByUserId': instance.createdByUserId,
  'createdByRoleId': instance.createdByRoleId,
  'items': instance.items,
  'metadata': instance.metadata,
  'notes': instance.notes,
};

_$OrderItemRequestImpl _$$OrderItemRequestImplFromJson(
  Map<String, dynamic> json,
) => _$OrderItemRequestImpl(
  productId: json['productId'] as String?,
  productName: json['productName'] as String,
  productSku: json['productSku'] as String?,
  unitPrice: (json['unitPrice'] as num).toDouble(),
  quantity: (json['quantity'] as num).toInt(),
  taxRate: (json['taxRate'] as num?)?.toDouble() ?? 0.0,
  discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0.0,
  modifiers: json['modifiers'] as Map<String, dynamic>?,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$$OrderItemRequestImplToJson(
  _$OrderItemRequestImpl instance,
) => <String, dynamic>{
  'productId': instance.productId,
  'productName': instance.productName,
  'productSku': instance.productSku,
  'unitPrice': instance.unitPrice,
  'quantity': instance.quantity,
  'taxRate': instance.taxRate,
  'discountAmount': instance.discountAmount,
  'modifiers': instance.modifiers,
  'notes': instance.notes,
};

_$CompleteOrderRequestImpl _$$CompleteOrderRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CompleteOrderRequestImpl(
  payments: (json['payments'] as List<dynamic>)
      .map((e) => PaymentRequest.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$CompleteOrderRequestImplToJson(
  _$CompleteOrderRequestImpl instance,
) => <String, dynamic>{'payments': instance.payments};

_$PaymentRequestImpl _$$PaymentRequestImplFromJson(Map<String, dynamic> json) =>
    _$PaymentRequestImpl(
      paymentMethod: json['paymentMethod'] as String,
      amount: (json['amount'] as num).toDouble(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$PaymentRequestImplToJson(
  _$PaymentRequestImpl instance,
) => <String, dynamic>{
  'paymentMethod': instance.paymentMethod,
  'amount': instance.amount,
  'metadata': instance.metadata,
};

_$CancelOrderRequestImpl _$$CancelOrderRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CancelOrderRequestImpl(
  reason: json['reason'] as String?,
  restoreStock: json['restoreStock'] as bool? ?? false,
);

Map<String, dynamic> _$$CancelOrderRequestImplToJson(
  _$CancelOrderRequestImpl instance,
) => <String, dynamic>{
  'reason': instance.reason,
  'restoreStock': instance.restoreStock,
};
