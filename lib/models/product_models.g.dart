// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      businessId: json['business_id'] as String,
      categoryId: json['category'] as String?,
      name: json['name'] as String,
      sku: json['sku'] as String?,
      basePrice: (json['base_price'] as num).toDouble(),
      taxRate: (json['tax_rate'] as num).toDouble(),
      metadata: json['metadata'] as Map<String, dynamic>?,
      isActive: json['is_active'] as bool,
      stockQuantity: (json['stock_quantity'] as num).toInt(),
      version: (json['version'] as num?)?.toInt() ?? 1,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'business_id': instance.businessId,
      'category': instance.categoryId,
      'name': instance.name,
      'sku': instance.sku,
      'base_price': instance.basePrice,
      'tax_rate': instance.taxRate,
      'metadata': instance.metadata,
      'is_active': instance.isActive,
      'stock_quantity': instance.stockQuantity,
      'version': instance.version,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      id: json['id'] as String,
      businessId: json['businessId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      displayOrder: (json['displayOrder'] as num).toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'businessId': instance.businessId,
      'name': instance.name,
      'description': instance.description,
      'displayOrder': instance.displayOrder,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$CreateProductRequestImpl _$$CreateProductRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateProductRequestImpl(
  businessId: json['businessId'] as String,
  categoryId: json['categoryId'] as String?,
  name: json['name'] as String,
  sku: json['sku'] as String?,
  basePrice: (json['basePrice'] as num).toDouble(),
  taxRate: (json['taxRate'] as num?)?.toDouble() ?? 0.0,
  metadata: json['metadata'] as Map<String, dynamic>?,
  isActive: json['isActive'] as bool? ?? true,
  stockQuantity: (json['stockQuantity'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$CreateProductRequestImplToJson(
  _$CreateProductRequestImpl instance,
) => <String, dynamic>{
  'businessId': instance.businessId,
  'categoryId': instance.categoryId,
  'name': instance.name,
  'sku': instance.sku,
  'basePrice': instance.basePrice,
  'taxRate': instance.taxRate,
  'metadata': instance.metadata,
  'isActive': instance.isActive,
  'stockQuantity': instance.stockQuantity,
};

_$UpdateProductRequestImpl _$$UpdateProductRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateProductRequestImpl(
  name: json['name'] as String?,
  categoryId: json['categoryId'] as String?,
  sku: json['sku'] as String?,
  basePrice: (json['basePrice'] as num?)?.toDouble(),
  taxRate: (json['taxRate'] as num?)?.toDouble(),
  metadata: json['metadata'] as Map<String, dynamic>?,
  isActive: json['isActive'] as bool?,
  stockQuantity: (json['stockQuantity'] as num?)?.toInt(),
  version: (json['version'] as num?)?.toInt(),
);

Map<String, dynamic> _$$UpdateProductRequestImplToJson(
  _$UpdateProductRequestImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'categoryId': instance.categoryId,
  'sku': instance.sku,
  'basePrice': instance.basePrice,
  'taxRate': instance.taxRate,
  'metadata': instance.metadata,
  'isActive': instance.isActive,
  'stockQuantity': instance.stockQuantity,
  'version': instance.version,
};

_$CreateCategoryRequestImpl _$$CreateCategoryRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateCategoryRequestImpl(
  businessId: json['businessId'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$CreateCategoryRequestImplToJson(
  _$CreateCategoryRequestImpl instance,
) => <String, dynamic>{
  'businessId': instance.businessId,
  'name': instance.name,
  'description': instance.description,
  'displayOrder': instance.displayOrder,
};
