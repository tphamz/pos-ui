// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  String get id => throw _privateConstructorUsedError;
  String get businessId => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get sku => throw _privateConstructorUsedError;
  double get basePrice => throw _privateConstructorUsedError;
  double get taxRate => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  int get stockQuantity => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call({
    String id,
    String businessId,
    String? categoryId,
    String name,
    String? sku,
    double basePrice,
    double taxRate,
    Map<String, dynamic>? metadata,
    bool isActive,
    int stockQuantity,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? categoryId = freezed,
    Object? name = null,
    Object? sku = freezed,
    Object? basePrice = null,
    Object? taxRate = null,
    Object? metadata = freezed,
    Object? isActive = null,
    Object? stockQuantity = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            businessId: null == businessId
                ? _value.businessId
                : businessId // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            sku: freezed == sku
                ? _value.sku
                : sku // ignore: cast_nullable_to_non_nullable
                      as String?,
            basePrice: null == basePrice
                ? _value.basePrice
                : basePrice // ignore: cast_nullable_to_non_nullable
                      as double,
            taxRate: null == taxRate
                ? _value.taxRate
                : taxRate // ignore: cast_nullable_to_non_nullable
                      as double,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            stockQuantity: null == stockQuantity
                ? _value.stockQuantity
                : stockQuantity // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
    _$ProductImpl value,
    $Res Function(_$ProductImpl) then,
  ) = __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String businessId,
    String? categoryId,
    String name,
    String? sku,
    double basePrice,
    double taxRate,
    Map<String, dynamic>? metadata,
    bool isActive,
    int stockQuantity,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
    _$ProductImpl _value,
    $Res Function(_$ProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? categoryId = freezed,
    Object? name = null,
    Object? sku = freezed,
    Object? basePrice = null,
    Object? taxRate = null,
    Object? metadata = freezed,
    Object? isActive = null,
    Object? stockQuantity = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ProductImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        businessId: null == businessId
            ? _value.businessId
            : businessId // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        sku: freezed == sku
            ? _value.sku
            : sku // ignore: cast_nullable_to_non_nullable
                  as String?,
        basePrice: null == basePrice
            ? _value.basePrice
            : basePrice // ignore: cast_nullable_to_non_nullable
                  as double,
        taxRate: null == taxRate
            ? _value.taxRate
            : taxRate // ignore: cast_nullable_to_non_nullable
                  as double,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        stockQuantity: null == stockQuantity
            ? _value.stockQuantity
            : stockQuantity // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl implements _Product {
  const _$ProductImpl({
    required this.id,
    required this.businessId,
    this.categoryId,
    required this.name,
    this.sku,
    required this.basePrice,
    required this.taxRate,
    final Map<String, dynamic>? metadata,
    required this.isActive,
    required this.stockQuantity,
    this.createdAt,
    this.updatedAt,
  }) : _metadata = metadata;

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final String id;
  @override
  final String businessId;
  @override
  final String? categoryId;
  @override
  final String name;
  @override
  final String? sku;
  @override
  final double basePrice;
  @override
  final double taxRate;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final bool isActive;
  @override
  final int stockQuantity;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Product(id: $id, businessId: $businessId, categoryId: $categoryId, name: $name, sku: $sku, basePrice: $basePrice, taxRate: $taxRate, metadata: $metadata, isActive: $isActive, stockQuantity: $stockQuantity, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.stockQuantity, stockQuantity) ||
                other.stockQuantity == stockQuantity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    businessId,
    categoryId,
    name,
    sku,
    basePrice,
    taxRate,
    const DeepCollectionEquality().hash(_metadata),
    isActive,
    stockQuantity,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(this);
  }
}

abstract class _Product implements Product {
  const factory _Product({
    required final String id,
    required final String businessId,
    final String? categoryId,
    required final String name,
    final String? sku,
    required final double basePrice,
    required final double taxRate,
    final Map<String, dynamic>? metadata,
    required final bool isActive,
    required final int stockQuantity,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  String get id;
  @override
  String get businessId;
  @override
  String? get categoryId;
  @override
  String get name;
  @override
  String? get sku;
  @override
  double get basePrice;
  @override
  double get taxRate;
  @override
  Map<String, dynamic>? get metadata;
  @override
  bool get isActive;
  @override
  int get stockQuantity;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return _Category.fromJson(json);
}

/// @nodoc
mixin _$Category {
  String get id => throw _privateConstructorUsedError;
  String get businessId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get displayOrder => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Category to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryCopyWith<Category> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryCopyWith<$Res> {
  factory $CategoryCopyWith(Category value, $Res Function(Category) then) =
      _$CategoryCopyWithImpl<$Res, Category>;
  @useResult
  $Res call({
    String id,
    String businessId,
    String name,
    String? description,
    int displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$CategoryCopyWithImpl<$Res, $Val extends Category>
    implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? name = null,
    Object? description = freezed,
    Object? displayOrder = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            businessId: null == businessId
                ? _value.businessId
                : businessId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            displayOrder: null == displayOrder
                ? _value.displayOrder
                : displayOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategoryImplCopyWith<$Res>
    implements $CategoryCopyWith<$Res> {
  factory _$$CategoryImplCopyWith(
    _$CategoryImpl value,
    $Res Function(_$CategoryImpl) then,
  ) = __$$CategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String businessId,
    String name,
    String? description,
    int displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$CategoryImplCopyWithImpl<$Res>
    extends _$CategoryCopyWithImpl<$Res, _$CategoryImpl>
    implements _$$CategoryImplCopyWith<$Res> {
  __$$CategoryImplCopyWithImpl(
    _$CategoryImpl _value,
    $Res Function(_$CategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? name = null,
    Object? description = freezed,
    Object? displayOrder = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$CategoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        businessId: null == businessId
            ? _value.businessId
            : businessId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        displayOrder: null == displayOrder
            ? _value.displayOrder
            : displayOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryImpl implements _Category {
  const _$CategoryImpl({
    required this.id,
    required this.businessId,
    required this.name,
    this.description,
    required this.displayOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory _$CategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryImplFromJson(json);

  @override
  final String id;
  @override
  final String businessId;
  @override
  final String name;
  @override
  final String? description;
  @override
  final int displayOrder;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Category(id: $id, businessId: $businessId, name: $name, description: $description, displayOrder: $displayOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    businessId,
    name,
    description,
    displayOrder,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      __$$CategoryImplCopyWithImpl<_$CategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryImplToJson(this);
  }
}

abstract class _Category implements Category {
  const factory _Category({
    required final String id,
    required final String businessId,
    required final String name,
    final String? description,
    required final int displayOrder,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$CategoryImpl;

  factory _Category.fromJson(Map<String, dynamic> json) =
      _$CategoryImpl.fromJson;

  @override
  String get id;
  @override
  String get businessId;
  @override
  String get name;
  @override
  String? get description;
  @override
  int get displayOrder;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateProductRequest _$CreateProductRequestFromJson(Map<String, dynamic> json) {
  return _CreateProductRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateProductRequest {
  String get businessId => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get sku => throw _privateConstructorUsedError;
  double get basePrice => throw _privateConstructorUsedError;
  double get taxRate => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  int get stockQuantity => throw _privateConstructorUsedError;

  /// Serializes this CreateProductRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateProductRequestCopyWith<CreateProductRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateProductRequestCopyWith<$Res> {
  factory $CreateProductRequestCopyWith(
    CreateProductRequest value,
    $Res Function(CreateProductRequest) then,
  ) = _$CreateProductRequestCopyWithImpl<$Res, CreateProductRequest>;
  @useResult
  $Res call({
    String businessId,
    String? categoryId,
    String name,
    String? sku,
    double basePrice,
    double taxRate,
    Map<String, dynamic>? metadata,
    bool isActive,
    int stockQuantity,
  });
}

/// @nodoc
class _$CreateProductRequestCopyWithImpl<
  $Res,
  $Val extends CreateProductRequest
>
    implements $CreateProductRequestCopyWith<$Res> {
  _$CreateProductRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? businessId = null,
    Object? categoryId = freezed,
    Object? name = null,
    Object? sku = freezed,
    Object? basePrice = null,
    Object? taxRate = null,
    Object? metadata = freezed,
    Object? isActive = null,
    Object? stockQuantity = null,
  }) {
    return _then(
      _value.copyWith(
            businessId: null == businessId
                ? _value.businessId
                : businessId // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            sku: freezed == sku
                ? _value.sku
                : sku // ignore: cast_nullable_to_non_nullable
                      as String?,
            basePrice: null == basePrice
                ? _value.basePrice
                : basePrice // ignore: cast_nullable_to_non_nullable
                      as double,
            taxRate: null == taxRate
                ? _value.taxRate
                : taxRate // ignore: cast_nullable_to_non_nullable
                      as double,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            stockQuantity: null == stockQuantity
                ? _value.stockQuantity
                : stockQuantity // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateProductRequestImplCopyWith<$Res>
    implements $CreateProductRequestCopyWith<$Res> {
  factory _$$CreateProductRequestImplCopyWith(
    _$CreateProductRequestImpl value,
    $Res Function(_$CreateProductRequestImpl) then,
  ) = __$$CreateProductRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String businessId,
    String? categoryId,
    String name,
    String? sku,
    double basePrice,
    double taxRate,
    Map<String, dynamic>? metadata,
    bool isActive,
    int stockQuantity,
  });
}

/// @nodoc
class __$$CreateProductRequestImplCopyWithImpl<$Res>
    extends _$CreateProductRequestCopyWithImpl<$Res, _$CreateProductRequestImpl>
    implements _$$CreateProductRequestImplCopyWith<$Res> {
  __$$CreateProductRequestImplCopyWithImpl(
    _$CreateProductRequestImpl _value,
    $Res Function(_$CreateProductRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? businessId = null,
    Object? categoryId = freezed,
    Object? name = null,
    Object? sku = freezed,
    Object? basePrice = null,
    Object? taxRate = null,
    Object? metadata = freezed,
    Object? isActive = null,
    Object? stockQuantity = null,
  }) {
    return _then(
      _$CreateProductRequestImpl(
        businessId: null == businessId
            ? _value.businessId
            : businessId // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        sku: freezed == sku
            ? _value.sku
            : sku // ignore: cast_nullable_to_non_nullable
                  as String?,
        basePrice: null == basePrice
            ? _value.basePrice
            : basePrice // ignore: cast_nullable_to_non_nullable
                  as double,
        taxRate: null == taxRate
            ? _value.taxRate
            : taxRate // ignore: cast_nullable_to_non_nullable
                  as double,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        stockQuantity: null == stockQuantity
            ? _value.stockQuantity
            : stockQuantity // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateProductRequestImpl implements _CreateProductRequest {
  const _$CreateProductRequestImpl({
    required this.businessId,
    this.categoryId,
    required this.name,
    this.sku,
    required this.basePrice,
    this.taxRate = 0.0,
    final Map<String, dynamic>? metadata,
    this.isActive = true,
    this.stockQuantity = 0,
  }) : _metadata = metadata;

  factory _$CreateProductRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateProductRequestImplFromJson(json);

  @override
  final String businessId;
  @override
  final String? categoryId;
  @override
  final String name;
  @override
  final String? sku;
  @override
  final double basePrice;
  @override
  @JsonKey()
  final double taxRate;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final int stockQuantity;

  @override
  String toString() {
    return 'CreateProductRequest(businessId: $businessId, categoryId: $categoryId, name: $name, sku: $sku, basePrice: $basePrice, taxRate: $taxRate, metadata: $metadata, isActive: $isActive, stockQuantity: $stockQuantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateProductRequestImpl &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.stockQuantity, stockQuantity) ||
                other.stockQuantity == stockQuantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    businessId,
    categoryId,
    name,
    sku,
    basePrice,
    taxRate,
    const DeepCollectionEquality().hash(_metadata),
    isActive,
    stockQuantity,
  );

  /// Create a copy of CreateProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateProductRequestImplCopyWith<_$CreateProductRequestImpl>
  get copyWith =>
      __$$CreateProductRequestImplCopyWithImpl<_$CreateProductRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateProductRequestImplToJson(this);
  }
}

abstract class _CreateProductRequest implements CreateProductRequest {
  const factory _CreateProductRequest({
    required final String businessId,
    final String? categoryId,
    required final String name,
    final String? sku,
    required final double basePrice,
    final double taxRate,
    final Map<String, dynamic>? metadata,
    final bool isActive,
    final int stockQuantity,
  }) = _$CreateProductRequestImpl;

  factory _CreateProductRequest.fromJson(Map<String, dynamic> json) =
      _$CreateProductRequestImpl.fromJson;

  @override
  String get businessId;
  @override
  String? get categoryId;
  @override
  String get name;
  @override
  String? get sku;
  @override
  double get basePrice;
  @override
  double get taxRate;
  @override
  Map<String, dynamic>? get metadata;
  @override
  bool get isActive;
  @override
  int get stockQuantity;

  /// Create a copy of CreateProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateProductRequestImplCopyWith<_$CreateProductRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UpdateProductRequest _$UpdateProductRequestFromJson(Map<String, dynamic> json) {
  return _UpdateProductRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateProductRequest {
  String? get name => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  String? get sku => throw _privateConstructorUsedError;
  double? get basePrice => throw _privateConstructorUsedError;
  double? get taxRate => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  int? get stockQuantity => throw _privateConstructorUsedError;

  /// Serializes this UpdateProductRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateProductRequestCopyWith<UpdateProductRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateProductRequestCopyWith<$Res> {
  factory $UpdateProductRequestCopyWith(
    UpdateProductRequest value,
    $Res Function(UpdateProductRequest) then,
  ) = _$UpdateProductRequestCopyWithImpl<$Res, UpdateProductRequest>;
  @useResult
  $Res call({
    String? name,
    String? categoryId,
    String? sku,
    double? basePrice,
    double? taxRate,
    Map<String, dynamic>? metadata,
    bool? isActive,
    int? stockQuantity,
  });
}

/// @nodoc
class _$UpdateProductRequestCopyWithImpl<
  $Res,
  $Val extends UpdateProductRequest
>
    implements $UpdateProductRequestCopyWith<$Res> {
  _$UpdateProductRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? categoryId = freezed,
    Object? sku = freezed,
    Object? basePrice = freezed,
    Object? taxRate = freezed,
    Object? metadata = freezed,
    Object? isActive = freezed,
    Object? stockQuantity = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            sku: freezed == sku
                ? _value.sku
                : sku // ignore: cast_nullable_to_non_nullable
                      as String?,
            basePrice: freezed == basePrice
                ? _value.basePrice
                : basePrice // ignore: cast_nullable_to_non_nullable
                      as double?,
            taxRate: freezed == taxRate
                ? _value.taxRate
                : taxRate // ignore: cast_nullable_to_non_nullable
                      as double?,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            isActive: freezed == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool?,
            stockQuantity: freezed == stockQuantity
                ? _value.stockQuantity
                : stockQuantity // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateProductRequestImplCopyWith<$Res>
    implements $UpdateProductRequestCopyWith<$Res> {
  factory _$$UpdateProductRequestImplCopyWith(
    _$UpdateProductRequestImpl value,
    $Res Function(_$UpdateProductRequestImpl) then,
  ) = __$$UpdateProductRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? name,
    String? categoryId,
    String? sku,
    double? basePrice,
    double? taxRate,
    Map<String, dynamic>? metadata,
    bool? isActive,
    int? stockQuantity,
  });
}

/// @nodoc
class __$$UpdateProductRequestImplCopyWithImpl<$Res>
    extends _$UpdateProductRequestCopyWithImpl<$Res, _$UpdateProductRequestImpl>
    implements _$$UpdateProductRequestImplCopyWith<$Res> {
  __$$UpdateProductRequestImplCopyWithImpl(
    _$UpdateProductRequestImpl _value,
    $Res Function(_$UpdateProductRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? categoryId = freezed,
    Object? sku = freezed,
    Object? basePrice = freezed,
    Object? taxRate = freezed,
    Object? metadata = freezed,
    Object? isActive = freezed,
    Object? stockQuantity = freezed,
  }) {
    return _then(
      _$UpdateProductRequestImpl(
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        sku: freezed == sku
            ? _value.sku
            : sku // ignore: cast_nullable_to_non_nullable
                  as String?,
        basePrice: freezed == basePrice
            ? _value.basePrice
            : basePrice // ignore: cast_nullable_to_non_nullable
                  as double?,
        taxRate: freezed == taxRate
            ? _value.taxRate
            : taxRate // ignore: cast_nullable_to_non_nullable
                  as double?,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        isActive: freezed == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool?,
        stockQuantity: freezed == stockQuantity
            ? _value.stockQuantity
            : stockQuantity // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateProductRequestImpl implements _UpdateProductRequest {
  const _$UpdateProductRequestImpl({
    this.name,
    this.categoryId,
    this.sku,
    this.basePrice,
    this.taxRate,
    final Map<String, dynamic>? metadata,
    this.isActive,
    this.stockQuantity,
  }) : _metadata = metadata;

  factory _$UpdateProductRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateProductRequestImplFromJson(json);

  @override
  final String? name;
  @override
  final String? categoryId;
  @override
  final String? sku;
  @override
  final double? basePrice;
  @override
  final double? taxRate;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final bool? isActive;
  @override
  final int? stockQuantity;

  @override
  String toString() {
    return 'UpdateProductRequest(name: $name, categoryId: $categoryId, sku: $sku, basePrice: $basePrice, taxRate: $taxRate, metadata: $metadata, isActive: $isActive, stockQuantity: $stockQuantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateProductRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.stockQuantity, stockQuantity) ||
                other.stockQuantity == stockQuantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    categoryId,
    sku,
    basePrice,
    taxRate,
    const DeepCollectionEquality().hash(_metadata),
    isActive,
    stockQuantity,
  );

  /// Create a copy of UpdateProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateProductRequestImplCopyWith<_$UpdateProductRequestImpl>
  get copyWith =>
      __$$UpdateProductRequestImplCopyWithImpl<_$UpdateProductRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateProductRequestImplToJson(this);
  }
}

abstract class _UpdateProductRequest implements UpdateProductRequest {
  const factory _UpdateProductRequest({
    final String? name,
    final String? categoryId,
    final String? sku,
    final double? basePrice,
    final double? taxRate,
    final Map<String, dynamic>? metadata,
    final bool? isActive,
    final int? stockQuantity,
  }) = _$UpdateProductRequestImpl;

  factory _UpdateProductRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateProductRequestImpl.fromJson;

  @override
  String? get name;
  @override
  String? get categoryId;
  @override
  String? get sku;
  @override
  double? get basePrice;
  @override
  double? get taxRate;
  @override
  Map<String, dynamic>? get metadata;
  @override
  bool? get isActive;
  @override
  int? get stockQuantity;

  /// Create a copy of UpdateProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateProductRequestImplCopyWith<_$UpdateProductRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CreateCategoryRequest _$CreateCategoryRequestFromJson(
  Map<String, dynamic> json,
) {
  return _CreateCategoryRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateCategoryRequest {
  String get businessId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get displayOrder => throw _privateConstructorUsedError;

  /// Serializes this CreateCategoryRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateCategoryRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateCategoryRequestCopyWith<CreateCategoryRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateCategoryRequestCopyWith<$Res> {
  factory $CreateCategoryRequestCopyWith(
    CreateCategoryRequest value,
    $Res Function(CreateCategoryRequest) then,
  ) = _$CreateCategoryRequestCopyWithImpl<$Res, CreateCategoryRequest>;
  @useResult
  $Res call({
    String businessId,
    String name,
    String? description,
    int displayOrder,
  });
}

/// @nodoc
class _$CreateCategoryRequestCopyWithImpl<
  $Res,
  $Val extends CreateCategoryRequest
>
    implements $CreateCategoryRequestCopyWith<$Res> {
  _$CreateCategoryRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateCategoryRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? businessId = null,
    Object? name = null,
    Object? description = freezed,
    Object? displayOrder = null,
  }) {
    return _then(
      _value.copyWith(
            businessId: null == businessId
                ? _value.businessId
                : businessId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            displayOrder: null == displayOrder
                ? _value.displayOrder
                : displayOrder // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateCategoryRequestImplCopyWith<$Res>
    implements $CreateCategoryRequestCopyWith<$Res> {
  factory _$$CreateCategoryRequestImplCopyWith(
    _$CreateCategoryRequestImpl value,
    $Res Function(_$CreateCategoryRequestImpl) then,
  ) = __$$CreateCategoryRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String businessId,
    String name,
    String? description,
    int displayOrder,
  });
}

/// @nodoc
class __$$CreateCategoryRequestImplCopyWithImpl<$Res>
    extends
        _$CreateCategoryRequestCopyWithImpl<$Res, _$CreateCategoryRequestImpl>
    implements _$$CreateCategoryRequestImplCopyWith<$Res> {
  __$$CreateCategoryRequestImplCopyWithImpl(
    _$CreateCategoryRequestImpl _value,
    $Res Function(_$CreateCategoryRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateCategoryRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? businessId = null,
    Object? name = null,
    Object? description = freezed,
    Object? displayOrder = null,
  }) {
    return _then(
      _$CreateCategoryRequestImpl(
        businessId: null == businessId
            ? _value.businessId
            : businessId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        displayOrder: null == displayOrder
            ? _value.displayOrder
            : displayOrder // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateCategoryRequestImpl implements _CreateCategoryRequest {
  const _$CreateCategoryRequestImpl({
    required this.businessId,
    required this.name,
    this.description,
    this.displayOrder = 0,
  });

  factory _$CreateCategoryRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateCategoryRequestImplFromJson(json);

  @override
  final String businessId;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey()
  final int displayOrder;

  @override
  String toString() {
    return 'CreateCategoryRequest(businessId: $businessId, name: $name, description: $description, displayOrder: $displayOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateCategoryRequestImpl &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, businessId, name, description, displayOrder);

  /// Create a copy of CreateCategoryRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateCategoryRequestImplCopyWith<_$CreateCategoryRequestImpl>
  get copyWith =>
      __$$CreateCategoryRequestImplCopyWithImpl<_$CreateCategoryRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateCategoryRequestImplToJson(this);
  }
}

abstract class _CreateCategoryRequest implements CreateCategoryRequest {
  const factory _CreateCategoryRequest({
    required final String businessId,
    required final String name,
    final String? description,
    final int displayOrder,
  }) = _$CreateCategoryRequestImpl;

  factory _CreateCategoryRequest.fromJson(Map<String, dynamic> json) =
      _$CreateCategoryRequestImpl.fromJson;

  @override
  String get businessId;
  @override
  String get name;
  @override
  String? get description;
  @override
  int get displayOrder;

  /// Create a copy of CreateCategoryRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateCategoryRequestImplCopyWith<_$CreateCategoryRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
