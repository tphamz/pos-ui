import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_models.freezed.dart';
part 'product_models.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String businessId,
    String? categoryId,
    required String name,
    String? sku,
    required double basePrice,
    required double taxRate,
    Map<String, dynamic>? metadata,
    required bool isActive,
    required int stockQuantity,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@freezed
class Category with _$Category {
  const factory Category({
    required String id,
    required String businessId,
    required String name,
    String? description,
    required int displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@freezed
class CreateProductRequest with _$CreateProductRequest {
  const factory CreateProductRequest({
    required String businessId,
    String? categoryId,
    required String name,
    String? sku,
    required double basePrice,
    @Default(0.0) double taxRate,
    Map<String, dynamic>? metadata,
    @Default(true) bool isActive,
    @Default(0) int stockQuantity,
  }) = _CreateProductRequest;

  factory CreateProductRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateProductRequestFromJson(json);
}

@freezed
class UpdateProductRequest with _$UpdateProductRequest {
  const factory UpdateProductRequest({
    String? name,
    String? categoryId,
    String? sku,
    double? basePrice,
    double? taxRate,
    Map<String, dynamic>? metadata,
    bool? isActive,
    int? stockQuantity,
  }) = _UpdateProductRequest;

  factory UpdateProductRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProductRequestFromJson(json);
}

@freezed
class CreateCategoryRequest with _$CreateCategoryRequest {
  const factory CreateCategoryRequest({
    required String businessId,
    required String name,
    String? description,
    @Default(0) int displayOrder,
  }) = _CreateCategoryRequest;

  factory CreateCategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCategoryRequestFromJson(json);
}
