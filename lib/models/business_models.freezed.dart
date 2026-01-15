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
