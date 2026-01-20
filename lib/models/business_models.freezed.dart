// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Business _$BusinessFromJson(Map<String, dynamic> json) {
  return _Business.fromJson(json);
}

/// @nodoc
mixin _$Business {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_code')
  String? get storeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_number')
  String? get taxNumber => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  String? get timezone => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'blueprint_id')
  String? get blueprintId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Business to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessCopyWith<Business> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessCopyWith<$Res> {
  factory $BusinessCopyWith(Business value, $Res Function(Business) then) =
      _$BusinessCopyWithImpl<$Res, Business>;
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'store_code') String? storeCode,
    @JsonKey(name: 'tax_number') String? taxNumber,
    String? currency,
    String? timezone,
    String? status,
    @JsonKey(name: 'blueprint_id') String? blueprintId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class _$BusinessCopyWithImpl<$Res, $Val extends Business>
    implements $BusinessCopyWith<$Res> {
  _$BusinessCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? storeCode = freezed,
    Object? taxNumber = freezed,
    Object? currency = freezed,
    Object? timezone = freezed,
    Object? status = freezed,
    Object? blueprintId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            storeCode: freezed == storeCode
                ? _value.storeCode
                : storeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            taxNumber: freezed == taxNumber
                ? _value.taxNumber
                : taxNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            currency: freezed == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String?,
            timezone: freezed == timezone
                ? _value.timezone
                : timezone // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            blueprintId: freezed == blueprintId
                ? _value.blueprintId
                : blueprintId // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$BusinessImplCopyWith<$Res>
    implements $BusinessCopyWith<$Res> {
  factory _$$BusinessImplCopyWith(
    _$BusinessImpl value,
    $Res Function(_$BusinessImpl) then,
  ) = __$$BusinessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'store_code') String? storeCode,
    @JsonKey(name: 'tax_number') String? taxNumber,
    String? currency,
    String? timezone,
    String? status,
    @JsonKey(name: 'blueprint_id') String? blueprintId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class __$$BusinessImplCopyWithImpl<$Res>
    extends _$BusinessCopyWithImpl<$Res, _$BusinessImpl>
    implements _$$BusinessImplCopyWith<$Res> {
  __$$BusinessImplCopyWithImpl(
    _$BusinessImpl _value,
    $Res Function(_$BusinessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? storeCode = freezed,
    Object? taxNumber = freezed,
    Object? currency = freezed,
    Object? timezone = freezed,
    Object? status = freezed,
    Object? blueprintId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$BusinessImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        storeCode: freezed == storeCode
            ? _value.storeCode
            : storeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        taxNumber: freezed == taxNumber
            ? _value.taxNumber
            : taxNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        currency: freezed == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String?,
        timezone: freezed == timezone
            ? _value.timezone
            : timezone // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        blueprintId: freezed == blueprintId
            ? _value.blueprintId
            : blueprintId // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$BusinessImpl implements _Business {
  const _$BusinessImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'store_code') this.storeCode,
    @JsonKey(name: 'tax_number') this.taxNumber,
    this.currency,
    this.timezone,
    this.status,
    @JsonKey(name: 'blueprint_id') this.blueprintId,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  });

  factory _$BusinessImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'store_code')
  final String? storeCode;
  @override
  @JsonKey(name: 'tax_number')
  final String? taxNumber;
  @override
  final String? currency;
  @override
  final String? timezone;
  @override
  final String? status;
  @override
  @JsonKey(name: 'blueprint_id')
  final String? blueprintId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Business(id: $id, name: $name, storeCode: $storeCode, taxNumber: $taxNumber, currency: $currency, timezone: $timezone, status: $status, blueprintId: $blueprintId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.storeCode, storeCode) ||
                other.storeCode == storeCode) &&
            (identical(other.taxNumber, taxNumber) ||
                other.taxNumber == taxNumber) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.blueprintId, blueprintId) ||
                other.blueprintId == blueprintId) &&
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
    name,
    storeCode,
    taxNumber,
    currency,
    timezone,
    status,
    blueprintId,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessImplCopyWith<_$BusinessImpl> get copyWith =>
      __$$BusinessImplCopyWithImpl<_$BusinessImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessImplToJson(this);
  }
}

abstract class _Business implements Business {
  const factory _Business({
    required final String id,
    required final String name,
    @JsonKey(name: 'store_code') final String? storeCode,
    @JsonKey(name: 'tax_number') final String? taxNumber,
    final String? currency,
    final String? timezone,
    final String? status,
    @JsonKey(name: 'blueprint_id') final String? blueprintId,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
  }) = _$BusinessImpl;

  factory _Business.fromJson(Map<String, dynamic> json) =
      _$BusinessImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'store_code')
  String? get storeCode;
  @override
  @JsonKey(name: 'tax_number')
  String? get taxNumber;
  @override
  String? get currency;
  @override
  String? get timezone;
  @override
  String? get status;
  @override
  @JsonKey(name: 'blueprint_id')
  String? get blueprintId;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessImplCopyWith<_$BusinessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateBusinessRequest _$CreateBusinessRequestFromJson(
  Map<String, dynamic> json,
) {
  return _CreateBusinessRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateBusinessRequest {
  String? get blueprintId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get storeCode => throw _privateConstructorUsedError;
  String? get taxNumber => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  String? get timezone => throw _privateConstructorUsedError;

  /// Serializes this CreateBusinessRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateBusinessRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateBusinessRequestCopyWith<CreateBusinessRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateBusinessRequestCopyWith<$Res> {
  factory $CreateBusinessRequestCopyWith(
    CreateBusinessRequest value,
    $Res Function(CreateBusinessRequest) then,
  ) = _$CreateBusinessRequestCopyWithImpl<$Res, CreateBusinessRequest>;
  @useResult
  $Res call({
    String? blueprintId,
    String name,
    String? storeCode,
    String? taxNumber,
    String? currency,
    String? timezone,
  });
}

/// @nodoc
class _$CreateBusinessRequestCopyWithImpl<
  $Res,
  $Val extends CreateBusinessRequest
>
    implements $CreateBusinessRequestCopyWith<$Res> {
  _$CreateBusinessRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateBusinessRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? blueprintId = freezed,
    Object? name = null,
    Object? storeCode = freezed,
    Object? taxNumber = freezed,
    Object? currency = freezed,
    Object? timezone = freezed,
  }) {
    return _then(
      _value.copyWith(
            blueprintId: freezed == blueprintId
                ? _value.blueprintId
                : blueprintId // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            storeCode: freezed == storeCode
                ? _value.storeCode
                : storeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            taxNumber: freezed == taxNumber
                ? _value.taxNumber
                : taxNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            currency: freezed == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String?,
            timezone: freezed == timezone
                ? _value.timezone
                : timezone // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateBusinessRequestImplCopyWith<$Res>
    implements $CreateBusinessRequestCopyWith<$Res> {
  factory _$$CreateBusinessRequestImplCopyWith(
    _$CreateBusinessRequestImpl value,
    $Res Function(_$CreateBusinessRequestImpl) then,
  ) = __$$CreateBusinessRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? blueprintId,
    String name,
    String? storeCode,
    String? taxNumber,
    String? currency,
    String? timezone,
  });
}

/// @nodoc
class __$$CreateBusinessRequestImplCopyWithImpl<$Res>
    extends
        _$CreateBusinessRequestCopyWithImpl<$Res, _$CreateBusinessRequestImpl>
    implements _$$CreateBusinessRequestImplCopyWith<$Res> {
  __$$CreateBusinessRequestImplCopyWithImpl(
    _$CreateBusinessRequestImpl _value,
    $Res Function(_$CreateBusinessRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateBusinessRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? blueprintId = freezed,
    Object? name = null,
    Object? storeCode = freezed,
    Object? taxNumber = freezed,
    Object? currency = freezed,
    Object? timezone = freezed,
  }) {
    return _then(
      _$CreateBusinessRequestImpl(
        blueprintId: freezed == blueprintId
            ? _value.blueprintId
            : blueprintId // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        storeCode: freezed == storeCode
            ? _value.storeCode
            : storeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        taxNumber: freezed == taxNumber
            ? _value.taxNumber
            : taxNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        currency: freezed == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String?,
        timezone: freezed == timezone
            ? _value.timezone
            : timezone // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateBusinessRequestImpl implements _CreateBusinessRequest {
  const _$CreateBusinessRequestImpl({
    this.blueprintId,
    required this.name,
    this.storeCode,
    this.taxNumber,
    this.currency,
    this.timezone,
  });

  factory _$CreateBusinessRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateBusinessRequestImplFromJson(json);

  @override
  final String? blueprintId;
  @override
  final String name;
  @override
  final String? storeCode;
  @override
  final String? taxNumber;
  @override
  final String? currency;
  @override
  final String? timezone;

  @override
  String toString() {
    return 'CreateBusinessRequest(blueprintId: $blueprintId, name: $name, storeCode: $storeCode, taxNumber: $taxNumber, currency: $currency, timezone: $timezone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateBusinessRequestImpl &&
            (identical(other.blueprintId, blueprintId) ||
                other.blueprintId == blueprintId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.storeCode, storeCode) ||
                other.storeCode == storeCode) &&
            (identical(other.taxNumber, taxNumber) ||
                other.taxNumber == taxNumber) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    blueprintId,
    name,
    storeCode,
    taxNumber,
    currency,
    timezone,
  );

  /// Create a copy of CreateBusinessRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateBusinessRequestImplCopyWith<_$CreateBusinessRequestImpl>
  get copyWith =>
      __$$CreateBusinessRequestImplCopyWithImpl<_$CreateBusinessRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateBusinessRequestImplToJson(this);
  }
}

abstract class _CreateBusinessRequest implements CreateBusinessRequest {
  const factory _CreateBusinessRequest({
    final String? blueprintId,
    required final String name,
    final String? storeCode,
    final String? taxNumber,
    final String? currency,
    final String? timezone,
  }) = _$CreateBusinessRequestImpl;

  factory _CreateBusinessRequest.fromJson(Map<String, dynamic> json) =
      _$CreateBusinessRequestImpl.fromJson;

  @override
  String? get blueprintId;
  @override
  String get name;
  @override
  String? get storeCode;
  @override
  String? get taxNumber;
  @override
  String? get currency;
  @override
  String? get timezone;

  /// Create a copy of CreateBusinessRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateBusinessRequestImplCopyWith<_$CreateBusinessRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UpdateBusinessRequest _$UpdateBusinessRequestFromJson(
  Map<String, dynamic> json,
) {
  return _UpdateBusinessRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateBusinessRequest {
  String? get name => throw _privateConstructorUsedError;
  String? get storeCode => throw _privateConstructorUsedError;
  String? get taxNumber => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  String? get timezone => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  /// Serializes this UpdateBusinessRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateBusinessRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateBusinessRequestCopyWith<UpdateBusinessRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateBusinessRequestCopyWith<$Res> {
  factory $UpdateBusinessRequestCopyWith(
    UpdateBusinessRequest value,
    $Res Function(UpdateBusinessRequest) then,
  ) = _$UpdateBusinessRequestCopyWithImpl<$Res, UpdateBusinessRequest>;
  @useResult
  $Res call({
    String? name,
    String? storeCode,
    String? taxNumber,
    String? currency,
    String? timezone,
    String? status,
  });
}

/// @nodoc
class _$UpdateBusinessRequestCopyWithImpl<
  $Res,
  $Val extends UpdateBusinessRequest
>
    implements $UpdateBusinessRequestCopyWith<$Res> {
  _$UpdateBusinessRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateBusinessRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? storeCode = freezed,
    Object? taxNumber = freezed,
    Object? currency = freezed,
    Object? timezone = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            storeCode: freezed == storeCode
                ? _value.storeCode
                : storeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            taxNumber: freezed == taxNumber
                ? _value.taxNumber
                : taxNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            currency: freezed == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String?,
            timezone: freezed == timezone
                ? _value.timezone
                : timezone // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateBusinessRequestImplCopyWith<$Res>
    implements $UpdateBusinessRequestCopyWith<$Res> {
  factory _$$UpdateBusinessRequestImplCopyWith(
    _$UpdateBusinessRequestImpl value,
    $Res Function(_$UpdateBusinessRequestImpl) then,
  ) = __$$UpdateBusinessRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? name,
    String? storeCode,
    String? taxNumber,
    String? currency,
    String? timezone,
    String? status,
  });
}

/// @nodoc
class __$$UpdateBusinessRequestImplCopyWithImpl<$Res>
    extends
        _$UpdateBusinessRequestCopyWithImpl<$Res, _$UpdateBusinessRequestImpl>
    implements _$$UpdateBusinessRequestImplCopyWith<$Res> {
  __$$UpdateBusinessRequestImplCopyWithImpl(
    _$UpdateBusinessRequestImpl _value,
    $Res Function(_$UpdateBusinessRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateBusinessRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? storeCode = freezed,
    Object? taxNumber = freezed,
    Object? currency = freezed,
    Object? timezone = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _$UpdateBusinessRequestImpl(
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        storeCode: freezed == storeCode
            ? _value.storeCode
            : storeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        taxNumber: freezed == taxNumber
            ? _value.taxNumber
            : taxNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        currency: freezed == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String?,
        timezone: freezed == timezone
            ? _value.timezone
            : timezone // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateBusinessRequestImpl implements _UpdateBusinessRequest {
  const _$UpdateBusinessRequestImpl({
    this.name,
    this.storeCode,
    this.taxNumber,
    this.currency,
    this.timezone,
    this.status,
  });

  factory _$UpdateBusinessRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateBusinessRequestImplFromJson(json);

  @override
  final String? name;
  @override
  final String? storeCode;
  @override
  final String? taxNumber;
  @override
  final String? currency;
  @override
  final String? timezone;
  @override
  final String? status;

  @override
  String toString() {
    return 'UpdateBusinessRequest(name: $name, storeCode: $storeCode, taxNumber: $taxNumber, currency: $currency, timezone: $timezone, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateBusinessRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.storeCode, storeCode) ||
                other.storeCode == storeCode) &&
            (identical(other.taxNumber, taxNumber) ||
                other.taxNumber == taxNumber) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    storeCode,
    taxNumber,
    currency,
    timezone,
    status,
  );

  /// Create a copy of UpdateBusinessRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateBusinessRequestImplCopyWith<_$UpdateBusinessRequestImpl>
  get copyWith =>
      __$$UpdateBusinessRequestImplCopyWithImpl<_$UpdateBusinessRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateBusinessRequestImplToJson(this);
  }
}

abstract class _UpdateBusinessRequest implements UpdateBusinessRequest {
  const factory _UpdateBusinessRequest({
    final String? name,
    final String? storeCode,
    final String? taxNumber,
    final String? currency,
    final String? timezone,
    final String? status,
  }) = _$UpdateBusinessRequestImpl;

  factory _UpdateBusinessRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateBusinessRequestImpl.fromJson;

  @override
  String? get name;
  @override
  String? get storeCode;
  @override
  String? get taxNumber;
  @override
  String? get currency;
  @override
  String? get timezone;
  @override
  String? get status;

  /// Create a copy of UpdateBusinessRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateBusinessRequestImplCopyWith<_$UpdateBusinessRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

BusinessDetailResponse _$BusinessDetailResponseFromJson(
  Map<String, dynamic> json,
) {
  return _BusinessDetailResponse.fromJson(json);
}

/// @nodoc
mixin _$BusinessDetailResponse {
  // Business fields (flattened from core.Business)
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_code')
  String? get storeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_number')
  String? get taxNumber => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  String? get timezone => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'blueprint_id')
  String? get blueprintId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError; // Additional fields from BusinessDetailResponse
  Blueprint? get blueprint => throw _privateConstructorUsedError;
  BusinessConfig? get config => throw _privateConstructorUsedError;

  /// Serializes this BusinessDetailResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessDetailResponseCopyWith<BusinessDetailResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessDetailResponseCopyWith<$Res> {
  factory $BusinessDetailResponseCopyWith(
    BusinessDetailResponse value,
    $Res Function(BusinessDetailResponse) then,
  ) = _$BusinessDetailResponseCopyWithImpl<$Res, BusinessDetailResponse>;
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'store_code') String? storeCode,
    @JsonKey(name: 'tax_number') String? taxNumber,
    String? currency,
    String? timezone,
    String? status,
    @JsonKey(name: 'blueprint_id') String? blueprintId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    Blueprint? blueprint,
    BusinessConfig? config,
  });

  $BlueprintCopyWith<$Res>? get blueprint;
  $BusinessConfigCopyWith<$Res>? get config;
}

/// @nodoc
class _$BusinessDetailResponseCopyWithImpl<
  $Res,
  $Val extends BusinessDetailResponse
>
    implements $BusinessDetailResponseCopyWith<$Res> {
  _$BusinessDetailResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? storeCode = freezed,
    Object? taxNumber = freezed,
    Object? currency = freezed,
    Object? timezone = freezed,
    Object? status = freezed,
    Object? blueprintId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? blueprint = freezed,
    Object? config = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            storeCode: freezed == storeCode
                ? _value.storeCode
                : storeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            taxNumber: freezed == taxNumber
                ? _value.taxNumber
                : taxNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            currency: freezed == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String?,
            timezone: freezed == timezone
                ? _value.timezone
                : timezone // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            blueprintId: freezed == blueprintId
                ? _value.blueprintId
                : blueprintId // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            blueprint: freezed == blueprint
                ? _value.blueprint
                : blueprint // ignore: cast_nullable_to_non_nullable
                      as Blueprint?,
            config: freezed == config
                ? _value.config
                : config // ignore: cast_nullable_to_non_nullable
                      as BusinessConfig?,
          )
          as $Val,
    );
  }

  /// Create a copy of BusinessDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BlueprintCopyWith<$Res>? get blueprint {
    if (_value.blueprint == null) {
      return null;
    }

    return $BlueprintCopyWith<$Res>(_value.blueprint!, (value) {
      return _then(_value.copyWith(blueprint: value) as $Val);
    });
  }

  /// Create a copy of BusinessDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BusinessConfigCopyWith<$Res>? get config {
    if (_value.config == null) {
      return null;
    }

    return $BusinessConfigCopyWith<$Res>(_value.config!, (value) {
      return _then(_value.copyWith(config: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BusinessDetailResponseImplCopyWith<$Res>
    implements $BusinessDetailResponseCopyWith<$Res> {
  factory _$$BusinessDetailResponseImplCopyWith(
    _$BusinessDetailResponseImpl value,
    $Res Function(_$BusinessDetailResponseImpl) then,
  ) = __$$BusinessDetailResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'store_code') String? storeCode,
    @JsonKey(name: 'tax_number') String? taxNumber,
    String? currency,
    String? timezone,
    String? status,
    @JsonKey(name: 'blueprint_id') String? blueprintId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    Blueprint? blueprint,
    BusinessConfig? config,
  });

  @override
  $BlueprintCopyWith<$Res>? get blueprint;
  @override
  $BusinessConfigCopyWith<$Res>? get config;
}

/// @nodoc
class __$$BusinessDetailResponseImplCopyWithImpl<$Res>
    extends
        _$BusinessDetailResponseCopyWithImpl<$Res, _$BusinessDetailResponseImpl>
    implements _$$BusinessDetailResponseImplCopyWith<$Res> {
  __$$BusinessDetailResponseImplCopyWithImpl(
    _$BusinessDetailResponseImpl _value,
    $Res Function(_$BusinessDetailResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusinessDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? storeCode = freezed,
    Object? taxNumber = freezed,
    Object? currency = freezed,
    Object? timezone = freezed,
    Object? status = freezed,
    Object? blueprintId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? blueprint = freezed,
    Object? config = freezed,
  }) {
    return _then(
      _$BusinessDetailResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        storeCode: freezed == storeCode
            ? _value.storeCode
            : storeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        taxNumber: freezed == taxNumber
            ? _value.taxNumber
            : taxNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        currency: freezed == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String?,
        timezone: freezed == timezone
            ? _value.timezone
            : timezone // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        blueprintId: freezed == blueprintId
            ? _value.blueprintId
            : blueprintId // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        blueprint: freezed == blueprint
            ? _value.blueprint
            : blueprint // ignore: cast_nullable_to_non_nullable
                  as Blueprint?,
        config: freezed == config
            ? _value.config
            : config // ignore: cast_nullable_to_non_nullable
                  as BusinessConfig?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessDetailResponseImpl implements _BusinessDetailResponse {
  const _$BusinessDetailResponseImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'store_code') this.storeCode,
    @JsonKey(name: 'tax_number') this.taxNumber,
    this.currency,
    this.timezone,
    this.status,
    @JsonKey(name: 'blueprint_id') this.blueprintId,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
    this.blueprint,
    this.config,
  });

  factory _$BusinessDetailResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessDetailResponseImplFromJson(json);

  // Business fields (flattened from core.Business)
  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'store_code')
  final String? storeCode;
  @override
  @JsonKey(name: 'tax_number')
  final String? taxNumber;
  @override
  final String? currency;
  @override
  final String? timezone;
  @override
  final String? status;
  @override
  @JsonKey(name: 'blueprint_id')
  final String? blueprintId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  // Additional fields from BusinessDetailResponse
  @override
  final Blueprint? blueprint;
  @override
  final BusinessConfig? config;

  @override
  String toString() {
    return 'BusinessDetailResponse(id: $id, name: $name, storeCode: $storeCode, taxNumber: $taxNumber, currency: $currency, timezone: $timezone, status: $status, blueprintId: $blueprintId, createdAt: $createdAt, updatedAt: $updatedAt, blueprint: $blueprint, config: $config)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessDetailResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.storeCode, storeCode) ||
                other.storeCode == storeCode) &&
            (identical(other.taxNumber, taxNumber) ||
                other.taxNumber == taxNumber) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.blueprintId, blueprintId) ||
                other.blueprintId == blueprintId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.blueprint, blueprint) ||
                other.blueprint == blueprint) &&
            (identical(other.config, config) || other.config == config));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    storeCode,
    taxNumber,
    currency,
    timezone,
    status,
    blueprintId,
    createdAt,
    updatedAt,
    blueprint,
    config,
  );

  /// Create a copy of BusinessDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessDetailResponseImplCopyWith<_$BusinessDetailResponseImpl>
  get copyWith =>
      __$$BusinessDetailResponseImplCopyWithImpl<_$BusinessDetailResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessDetailResponseImplToJson(this);
  }
}

abstract class _BusinessDetailResponse implements BusinessDetailResponse {
  const factory _BusinessDetailResponse({
    required final String id,
    required final String name,
    @JsonKey(name: 'store_code') final String? storeCode,
    @JsonKey(name: 'tax_number') final String? taxNumber,
    final String? currency,
    final String? timezone,
    final String? status,
    @JsonKey(name: 'blueprint_id') final String? blueprintId,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
    final Blueprint? blueprint,
    final BusinessConfig? config,
  }) = _$BusinessDetailResponseImpl;

  factory _BusinessDetailResponse.fromJson(Map<String, dynamic> json) =
      _$BusinessDetailResponseImpl.fromJson;

  // Business fields (flattened from core.Business)
  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'store_code')
  String? get storeCode;
  @override
  @JsonKey(name: 'tax_number')
  String? get taxNumber;
  @override
  String? get currency;
  @override
  String? get timezone;
  @override
  String? get status;
  @override
  @JsonKey(name: 'blueprint_id')
  String? get blueprintId;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt; // Additional fields from BusinessDetailResponse
  @override
  Blueprint? get blueprint;
  @override
  BusinessConfig? get config;

  /// Create a copy of BusinessDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessDetailResponseImplCopyWith<_$BusinessDetailResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

BusinessConfig _$BusinessConfigFromJson(Map<String, dynamic> json) {
  return _BusinessConfig.fromJson(json);
}

/// @nodoc
mixin _$BusinessConfig {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_id')
  String get businessId => throw _privateConstructorUsedError;
  @JsonKey(name: 'brand_settings')
  Map<String, dynamic>? get brandSettings => throw _privateConstructorUsedError;
  @JsonKey(name: 'active_modules')
  List<String>? get activeModules => throw _privateConstructorUsedError;
  @JsonKey(name: 'industry_data')
  Map<String, dynamic>? get industryData => throw _privateConstructorUsedError;
  @JsonKey(name: 'hardware_map')
  Map<String, dynamic>? get hardwareMap => throw _privateConstructorUsedError;
  int get version =>
      throw _privateConstructorUsedError; // Optimistic locking version
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this BusinessConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessConfigCopyWith<BusinessConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessConfigCopyWith<$Res> {
  factory $BusinessConfigCopyWith(
    BusinessConfig value,
    $Res Function(BusinessConfig) then,
  ) = _$BusinessConfigCopyWithImpl<$Res, BusinessConfig>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'business_id') String businessId,
    @JsonKey(name: 'brand_settings') Map<String, dynamic>? brandSettings,
    @JsonKey(name: 'active_modules') List<String>? activeModules,
    @JsonKey(name: 'industry_data') Map<String, dynamic>? industryData,
    @JsonKey(name: 'hardware_map') Map<String, dynamic>? hardwareMap,
    int version,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$BusinessConfigCopyWithImpl<$Res, $Val extends BusinessConfig>
    implements $BusinessConfigCopyWith<$Res> {
  _$BusinessConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? brandSettings = freezed,
    Object? activeModules = freezed,
    Object? industryData = freezed,
    Object? hardwareMap = freezed,
    Object? version = null,
    Object? updatedAt = null,
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
            brandSettings: freezed == brandSettings
                ? _value.brandSettings
                : brandSettings // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            activeModules: freezed == activeModules
                ? _value.activeModules
                : activeModules // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            industryData: freezed == industryData
                ? _value.industryData
                : industryData // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            hardwareMap: freezed == hardwareMap
                ? _value.hardwareMap
                : hardwareMap // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            version: null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as int,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BusinessConfigImplCopyWith<$Res>
    implements $BusinessConfigCopyWith<$Res> {
  factory _$$BusinessConfigImplCopyWith(
    _$BusinessConfigImpl value,
    $Res Function(_$BusinessConfigImpl) then,
  ) = __$$BusinessConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'business_id') String businessId,
    @JsonKey(name: 'brand_settings') Map<String, dynamic>? brandSettings,
    @JsonKey(name: 'active_modules') List<String>? activeModules,
    @JsonKey(name: 'industry_data') Map<String, dynamic>? industryData,
    @JsonKey(name: 'hardware_map') Map<String, dynamic>? hardwareMap,
    int version,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$BusinessConfigImplCopyWithImpl<$Res>
    extends _$BusinessConfigCopyWithImpl<$Res, _$BusinessConfigImpl>
    implements _$$BusinessConfigImplCopyWith<$Res> {
  __$$BusinessConfigImplCopyWithImpl(
    _$BusinessConfigImpl _value,
    $Res Function(_$BusinessConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusinessConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? brandSettings = freezed,
    Object? activeModules = freezed,
    Object? industryData = freezed,
    Object? hardwareMap = freezed,
    Object? version = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$BusinessConfigImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        businessId: null == businessId
            ? _value.businessId
            : businessId // ignore: cast_nullable_to_non_nullable
                  as String,
        brandSettings: freezed == brandSettings
            ? _value._brandSettings
            : brandSettings // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        activeModules: freezed == activeModules
            ? _value._activeModules
            : activeModules // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        industryData: freezed == industryData
            ? _value._industryData
            : industryData // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        hardwareMap: freezed == hardwareMap
            ? _value._hardwareMap
            : hardwareMap // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as int,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessConfigImpl implements _BusinessConfig {
  const _$BusinessConfigImpl({
    required this.id,
    @JsonKey(name: 'business_id') required this.businessId,
    @JsonKey(name: 'brand_settings') final Map<String, dynamic>? brandSettings,
    @JsonKey(name: 'active_modules') final List<String>? activeModules,
    @JsonKey(name: 'industry_data') final Map<String, dynamic>? industryData,
    @JsonKey(name: 'hardware_map') final Map<String, dynamic>? hardwareMap,
    this.version = 1,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  }) : _brandSettings = brandSettings,
       _activeModules = activeModules,
       _industryData = industryData,
       _hardwareMap = hardwareMap;

  factory _$BusinessConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessConfigImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'business_id')
  final String businessId;
  final Map<String, dynamic>? _brandSettings;
  @override
  @JsonKey(name: 'brand_settings')
  Map<String, dynamic>? get brandSettings {
    final value = _brandSettings;
    if (value == null) return null;
    if (_brandSettings is EqualUnmodifiableMapView) return _brandSettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _activeModules;
  @override
  @JsonKey(name: 'active_modules')
  List<String>? get activeModules {
    final value = _activeModules;
    if (value == null) return null;
    if (_activeModules is EqualUnmodifiableListView) return _activeModules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _industryData;
  @override
  @JsonKey(name: 'industry_data')
  Map<String, dynamic>? get industryData {
    final value = _industryData;
    if (value == null) return null;
    if (_industryData is EqualUnmodifiableMapView) return _industryData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _hardwareMap;
  @override
  @JsonKey(name: 'hardware_map')
  Map<String, dynamic>? get hardwareMap {
    final value = _hardwareMap;
    if (value == null) return null;
    if (_hardwareMap is EqualUnmodifiableMapView) return _hardwareMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final int version;
  // Optimistic locking version
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'BusinessConfig(id: $id, businessId: $businessId, brandSettings: $brandSettings, activeModules: $activeModules, industryData: $industryData, hardwareMap: $hardwareMap, version: $version, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            const DeepCollectionEquality().equals(
              other._brandSettings,
              _brandSettings,
            ) &&
            const DeepCollectionEquality().equals(
              other._activeModules,
              _activeModules,
            ) &&
            const DeepCollectionEquality().equals(
              other._industryData,
              _industryData,
            ) &&
            const DeepCollectionEquality().equals(
              other._hardwareMap,
              _hardwareMap,
            ) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    businessId,
    const DeepCollectionEquality().hash(_brandSettings),
    const DeepCollectionEquality().hash(_activeModules),
    const DeepCollectionEquality().hash(_industryData),
    const DeepCollectionEquality().hash(_hardwareMap),
    version,
    updatedAt,
  );

  /// Create a copy of BusinessConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessConfigImplCopyWith<_$BusinessConfigImpl> get copyWith =>
      __$$BusinessConfigImplCopyWithImpl<_$BusinessConfigImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessConfigImplToJson(this);
  }
}

abstract class _BusinessConfig implements BusinessConfig {
  const factory _BusinessConfig({
    required final String id,
    @JsonKey(name: 'business_id') required final String businessId,
    @JsonKey(name: 'brand_settings') final Map<String, dynamic>? brandSettings,
    @JsonKey(name: 'active_modules') final List<String>? activeModules,
    @JsonKey(name: 'industry_data') final Map<String, dynamic>? industryData,
    @JsonKey(name: 'hardware_map') final Map<String, dynamic>? hardwareMap,
    final int version,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$BusinessConfigImpl;

  factory _BusinessConfig.fromJson(Map<String, dynamic> json) =
      _$BusinessConfigImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'business_id')
  String get businessId;
  @override
  @JsonKey(name: 'brand_settings')
  Map<String, dynamic>? get brandSettings;
  @override
  @JsonKey(name: 'active_modules')
  List<String>? get activeModules;
  @override
  @JsonKey(name: 'industry_data')
  Map<String, dynamic>? get industryData;
  @override
  @JsonKey(name: 'hardware_map')
  Map<String, dynamic>? get hardwareMap;
  @override
  int get version; // Optimistic locking version
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of BusinessConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessConfigImplCopyWith<_$BusinessConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateBusinessConfigRequest _$UpdateBusinessConfigRequestFromJson(
  Map<String, dynamic> json,
) {
  return _UpdateBusinessConfigRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateBusinessConfigRequest {
  @JsonKey(name: 'brand_settings')
  Map<String, dynamic>? get brandSettings => throw _privateConstructorUsedError;
  @JsonKey(name: 'active_modules')
  List<String>? get activeModules => throw _privateConstructorUsedError;
  @JsonKey(name: 'industry_data')
  Map<String, dynamic>? get industryData => throw _privateConstructorUsedError;
  @JsonKey(name: 'hardware_map')
  Map<String, dynamic>? get hardwareMap => throw _privateConstructorUsedError;
  int? get version => throw _privateConstructorUsedError;

  /// Serializes this UpdateBusinessConfigRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateBusinessConfigRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateBusinessConfigRequestCopyWith<UpdateBusinessConfigRequest>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateBusinessConfigRequestCopyWith<$Res> {
  factory $UpdateBusinessConfigRequestCopyWith(
    UpdateBusinessConfigRequest value,
    $Res Function(UpdateBusinessConfigRequest) then,
  ) =
      _$UpdateBusinessConfigRequestCopyWithImpl<
        $Res,
        UpdateBusinessConfigRequest
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'brand_settings') Map<String, dynamic>? brandSettings,
    @JsonKey(name: 'active_modules') List<String>? activeModules,
    @JsonKey(name: 'industry_data') Map<String, dynamic>? industryData,
    @JsonKey(name: 'hardware_map') Map<String, dynamic>? hardwareMap,
    int? version,
  });
}

/// @nodoc
class _$UpdateBusinessConfigRequestCopyWithImpl<
  $Res,
  $Val extends UpdateBusinessConfigRequest
>
    implements $UpdateBusinessConfigRequestCopyWith<$Res> {
  _$UpdateBusinessConfigRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateBusinessConfigRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brandSettings = freezed,
    Object? activeModules = freezed,
    Object? industryData = freezed,
    Object? hardwareMap = freezed,
    Object? version = freezed,
  }) {
    return _then(
      _value.copyWith(
            brandSettings: freezed == brandSettings
                ? _value.brandSettings
                : brandSettings // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            activeModules: freezed == activeModules
                ? _value.activeModules
                : activeModules // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            industryData: freezed == industryData
                ? _value.industryData
                : industryData // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            hardwareMap: freezed == hardwareMap
                ? _value.hardwareMap
                : hardwareMap // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            version: freezed == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateBusinessConfigRequestImplCopyWith<$Res>
    implements $UpdateBusinessConfigRequestCopyWith<$Res> {
  factory _$$UpdateBusinessConfigRequestImplCopyWith(
    _$UpdateBusinessConfigRequestImpl value,
    $Res Function(_$UpdateBusinessConfigRequestImpl) then,
  ) = __$$UpdateBusinessConfigRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'brand_settings') Map<String, dynamic>? brandSettings,
    @JsonKey(name: 'active_modules') List<String>? activeModules,
    @JsonKey(name: 'industry_data') Map<String, dynamic>? industryData,
    @JsonKey(name: 'hardware_map') Map<String, dynamic>? hardwareMap,
    int? version,
  });
}

/// @nodoc
class __$$UpdateBusinessConfigRequestImplCopyWithImpl<$Res>
    extends
        _$UpdateBusinessConfigRequestCopyWithImpl<
          $Res,
          _$UpdateBusinessConfigRequestImpl
        >
    implements _$$UpdateBusinessConfigRequestImplCopyWith<$Res> {
  __$$UpdateBusinessConfigRequestImplCopyWithImpl(
    _$UpdateBusinessConfigRequestImpl _value,
    $Res Function(_$UpdateBusinessConfigRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateBusinessConfigRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brandSettings = freezed,
    Object? activeModules = freezed,
    Object? industryData = freezed,
    Object? hardwareMap = freezed,
    Object? version = freezed,
  }) {
    return _then(
      _$UpdateBusinessConfigRequestImpl(
        brandSettings: freezed == brandSettings
            ? _value._brandSettings
            : brandSettings // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        activeModules: freezed == activeModules
            ? _value._activeModules
            : activeModules // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        industryData: freezed == industryData
            ? _value._industryData
            : industryData // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        hardwareMap: freezed == hardwareMap
            ? _value._hardwareMap
            : hardwareMap // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        version: freezed == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateBusinessConfigRequestImpl
    implements _UpdateBusinessConfigRequest {
  const _$UpdateBusinessConfigRequestImpl({
    @JsonKey(name: 'brand_settings') final Map<String, dynamic>? brandSettings,
    @JsonKey(name: 'active_modules') final List<String>? activeModules,
    @JsonKey(name: 'industry_data') final Map<String, dynamic>? industryData,
    @JsonKey(name: 'hardware_map') final Map<String, dynamic>? hardwareMap,
    this.version,
  }) : _brandSettings = brandSettings,
       _activeModules = activeModules,
       _industryData = industryData,
       _hardwareMap = hardwareMap;

  factory _$UpdateBusinessConfigRequestImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$UpdateBusinessConfigRequestImplFromJson(json);

  final Map<String, dynamic>? _brandSettings;
  @override
  @JsonKey(name: 'brand_settings')
  Map<String, dynamic>? get brandSettings {
    final value = _brandSettings;
    if (value == null) return null;
    if (_brandSettings is EqualUnmodifiableMapView) return _brandSettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _activeModules;
  @override
  @JsonKey(name: 'active_modules')
  List<String>? get activeModules {
    final value = _activeModules;
    if (value == null) return null;
    if (_activeModules is EqualUnmodifiableListView) return _activeModules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _industryData;
  @override
  @JsonKey(name: 'industry_data')
  Map<String, dynamic>? get industryData {
    final value = _industryData;
    if (value == null) return null;
    if (_industryData is EqualUnmodifiableMapView) return _industryData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _hardwareMap;
  @override
  @JsonKey(name: 'hardware_map')
  Map<String, dynamic>? get hardwareMap {
    final value = _hardwareMap;
    if (value == null) return null;
    if (_hardwareMap is EqualUnmodifiableMapView) return _hardwareMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final int? version;

  @override
  String toString() {
    return 'UpdateBusinessConfigRequest(brandSettings: $brandSettings, activeModules: $activeModules, industryData: $industryData, hardwareMap: $hardwareMap, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateBusinessConfigRequestImpl &&
            const DeepCollectionEquality().equals(
              other._brandSettings,
              _brandSettings,
            ) &&
            const DeepCollectionEquality().equals(
              other._activeModules,
              _activeModules,
            ) &&
            const DeepCollectionEquality().equals(
              other._industryData,
              _industryData,
            ) &&
            const DeepCollectionEquality().equals(
              other._hardwareMap,
              _hardwareMap,
            ) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_brandSettings),
    const DeepCollectionEquality().hash(_activeModules),
    const DeepCollectionEquality().hash(_industryData),
    const DeepCollectionEquality().hash(_hardwareMap),
    version,
  );

  /// Create a copy of UpdateBusinessConfigRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateBusinessConfigRequestImplCopyWith<_$UpdateBusinessConfigRequestImpl>
  get copyWith =>
      __$$UpdateBusinessConfigRequestImplCopyWithImpl<
        _$UpdateBusinessConfigRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateBusinessConfigRequestImplToJson(this);
  }
}

abstract class _UpdateBusinessConfigRequest
    implements UpdateBusinessConfigRequest {
  const factory _UpdateBusinessConfigRequest({
    @JsonKey(name: 'brand_settings') final Map<String, dynamic>? brandSettings,
    @JsonKey(name: 'active_modules') final List<String>? activeModules,
    @JsonKey(name: 'industry_data') final Map<String, dynamic>? industryData,
    @JsonKey(name: 'hardware_map') final Map<String, dynamic>? hardwareMap,
    final int? version,
  }) = _$UpdateBusinessConfigRequestImpl;

  factory _UpdateBusinessConfigRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateBusinessConfigRequestImpl.fromJson;

  @override
  @JsonKey(name: 'brand_settings')
  Map<String, dynamic>? get brandSettings;
  @override
  @JsonKey(name: 'active_modules')
  List<String>? get activeModules;
  @override
  @JsonKey(name: 'industry_data')
  Map<String, dynamic>? get industryData;
  @override
  @JsonKey(name: 'hardware_map')
  Map<String, dynamic>? get hardwareMap;
  @override
  int? get version;

  /// Create a copy of UpdateBusinessConfigRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateBusinessConfigRequestImplCopyWith<_$UpdateBusinessConfigRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
