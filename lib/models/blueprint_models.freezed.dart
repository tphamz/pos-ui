// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blueprint_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BlueprintListItem _$BlueprintListItemFromJson(Map<String, dynamic> json) {
  return _BlueprintListItem.fromJson(json);
}

/// @nodoc
mixin _$BlueprintListItem {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'bp_code')
  String get bpCode => throw _privateConstructorUsedError;

  /// Serializes this BlueprintListItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BlueprintListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlueprintListItemCopyWith<BlueprintListItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlueprintListItemCopyWith<$Res> {
  factory $BlueprintListItemCopyWith(
    BlueprintListItem value,
    $Res Function(BlueprintListItem) then,
  ) = _$BlueprintListItemCopyWithImpl<$Res, BlueprintListItem>;
  @useResult
  $Res call({String id, String name, @JsonKey(name: 'bp_code') String bpCode});
}

/// @nodoc
class _$BlueprintListItemCopyWithImpl<$Res, $Val extends BlueprintListItem>
    implements $BlueprintListItemCopyWith<$Res> {
  _$BlueprintListItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BlueprintListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? bpCode = null}) {
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
            bpCode: null == bpCode
                ? _value.bpCode
                : bpCode // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BlueprintListItemImplCopyWith<$Res>
    implements $BlueprintListItemCopyWith<$Res> {
  factory _$$BlueprintListItemImplCopyWith(
    _$BlueprintListItemImpl value,
    $Res Function(_$BlueprintListItemImpl) then,
  ) = __$$BlueprintListItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, @JsonKey(name: 'bp_code') String bpCode});
}

/// @nodoc
class __$$BlueprintListItemImplCopyWithImpl<$Res>
    extends _$BlueprintListItemCopyWithImpl<$Res, _$BlueprintListItemImpl>
    implements _$$BlueprintListItemImplCopyWith<$Res> {
  __$$BlueprintListItemImplCopyWithImpl(
    _$BlueprintListItemImpl _value,
    $Res Function(_$BlueprintListItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BlueprintListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? bpCode = null}) {
    return _then(
      _$BlueprintListItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        bpCode: null == bpCode
            ? _value.bpCode
            : bpCode // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BlueprintListItemImpl implements _BlueprintListItem {
  const _$BlueprintListItemImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'bp_code') required this.bpCode,
  });

  factory _$BlueprintListItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlueprintListItemImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'bp_code')
  final String bpCode;

  @override
  String toString() {
    return 'BlueprintListItem(id: $id, name: $name, bpCode: $bpCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlueprintListItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.bpCode, bpCode) || other.bpCode == bpCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, bpCode);

  /// Create a copy of BlueprintListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlueprintListItemImplCopyWith<_$BlueprintListItemImpl> get copyWith =>
      __$$BlueprintListItemImplCopyWithImpl<_$BlueprintListItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BlueprintListItemImplToJson(this);
  }
}

abstract class _BlueprintListItem implements BlueprintListItem {
  const factory _BlueprintListItem({
    required final String id,
    required final String name,
    @JsonKey(name: 'bp_code') required final String bpCode,
  }) = _$BlueprintListItemImpl;

  factory _BlueprintListItem.fromJson(Map<String, dynamic> json) =
      _$BlueprintListItemImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'bp_code')
  String get bpCode;

  /// Create a copy of BlueprintListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlueprintListItemImplCopyWith<_$BlueprintListItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Blueprint _$BlueprintFromJson(Map<String, dynamic> json) {
  return _Blueprint.fromJson(json);
}

/// @nodoc
mixin _$Blueprint {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'bp_code')
  String get bpCode => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  @JsonKey(name: 'ui_schema')
  Map<String, dynamic>? get uiSchema => throw _privateConstructorUsedError;
  @JsonKey(name: 'module_definitions')
  Map<String, dynamic>? get moduleDefinitions =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'logic_rules')
  Map<String, dynamic>? get logicRules => throw _privateConstructorUsedError;
  @JsonKey(name: 'label_mappings')
  Map<String, dynamic>? get labelMappings => throw _privateConstructorUsedError;
  Map<String, dynamic>? get permissions => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Blueprint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Blueprint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlueprintCopyWith<Blueprint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlueprintCopyWith<$Res> {
  factory $BlueprintCopyWith(Blueprint value, $Res Function(Blueprint) then) =
      _$BlueprintCopyWithImpl<$Res, Blueprint>;
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'bp_code') String bpCode,
    int version,
    @JsonKey(name: 'ui_schema') Map<String, dynamic>? uiSchema,
    @JsonKey(name: 'module_definitions')
    Map<String, dynamic>? moduleDefinitions,
    @JsonKey(name: 'logic_rules') Map<String, dynamic>? logicRules,
    @JsonKey(name: 'label_mappings') Map<String, dynamic>? labelMappings,
    Map<String, dynamic>? permissions,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class _$BlueprintCopyWithImpl<$Res, $Val extends Blueprint>
    implements $BlueprintCopyWith<$Res> {
  _$BlueprintCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Blueprint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? bpCode = null,
    Object? version = null,
    Object? uiSchema = freezed,
    Object? moduleDefinitions = freezed,
    Object? logicRules = freezed,
    Object? labelMappings = freezed,
    Object? permissions = freezed,
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
            bpCode: null == bpCode
                ? _value.bpCode
                : bpCode // ignore: cast_nullable_to_non_nullable
                      as String,
            version: null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as int,
            uiSchema: freezed == uiSchema
                ? _value.uiSchema
                : uiSchema // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            moduleDefinitions: freezed == moduleDefinitions
                ? _value.moduleDefinitions
                : moduleDefinitions // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            logicRules: freezed == logicRules
                ? _value.logicRules
                : logicRules // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            labelMappings: freezed == labelMappings
                ? _value.labelMappings
                : labelMappings // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            permissions: freezed == permissions
                ? _value.permissions
                : permissions // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
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
abstract class _$$BlueprintImplCopyWith<$Res>
    implements $BlueprintCopyWith<$Res> {
  factory _$$BlueprintImplCopyWith(
    _$BlueprintImpl value,
    $Res Function(_$BlueprintImpl) then,
  ) = __$$BlueprintImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'bp_code') String bpCode,
    int version,
    @JsonKey(name: 'ui_schema') Map<String, dynamic>? uiSchema,
    @JsonKey(name: 'module_definitions')
    Map<String, dynamic>? moduleDefinitions,
    @JsonKey(name: 'logic_rules') Map<String, dynamic>? logicRules,
    @JsonKey(name: 'label_mappings') Map<String, dynamic>? labelMappings,
    Map<String, dynamic>? permissions,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class __$$BlueprintImplCopyWithImpl<$Res>
    extends _$BlueprintCopyWithImpl<$Res, _$BlueprintImpl>
    implements _$$BlueprintImplCopyWith<$Res> {
  __$$BlueprintImplCopyWithImpl(
    _$BlueprintImpl _value,
    $Res Function(_$BlueprintImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Blueprint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? bpCode = null,
    Object? version = null,
    Object? uiSchema = freezed,
    Object? moduleDefinitions = freezed,
    Object? logicRules = freezed,
    Object? labelMappings = freezed,
    Object? permissions = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$BlueprintImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        bpCode: null == bpCode
            ? _value.bpCode
            : bpCode // ignore: cast_nullable_to_non_nullable
                  as String,
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as int,
        uiSchema: freezed == uiSchema
            ? _value._uiSchema
            : uiSchema // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        moduleDefinitions: freezed == moduleDefinitions
            ? _value._moduleDefinitions
            : moduleDefinitions // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        logicRules: freezed == logicRules
            ? _value._logicRules
            : logicRules // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        labelMappings: freezed == labelMappings
            ? _value._labelMappings
            : labelMappings // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        permissions: freezed == permissions
            ? _value._permissions
            : permissions // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
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
class _$BlueprintImpl implements _Blueprint {
  const _$BlueprintImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'bp_code') required this.bpCode,
    required this.version,
    @JsonKey(name: 'ui_schema') final Map<String, dynamic>? uiSchema,
    @JsonKey(name: 'module_definitions')
    final Map<String, dynamic>? moduleDefinitions,
    @JsonKey(name: 'logic_rules') final Map<String, dynamic>? logicRules,
    @JsonKey(name: 'label_mappings') final Map<String, dynamic>? labelMappings,
    final Map<String, dynamic>? permissions,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  }) : _uiSchema = uiSchema,
       _moduleDefinitions = moduleDefinitions,
       _logicRules = logicRules,
       _labelMappings = labelMappings,
       _permissions = permissions;

  factory _$BlueprintImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlueprintImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'bp_code')
  final String bpCode;
  @override
  final int version;
  final Map<String, dynamic>? _uiSchema;
  @override
  @JsonKey(name: 'ui_schema')
  Map<String, dynamic>? get uiSchema {
    final value = _uiSchema;
    if (value == null) return null;
    if (_uiSchema is EqualUnmodifiableMapView) return _uiSchema;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _moduleDefinitions;
  @override
  @JsonKey(name: 'module_definitions')
  Map<String, dynamic>? get moduleDefinitions {
    final value = _moduleDefinitions;
    if (value == null) return null;
    if (_moduleDefinitions is EqualUnmodifiableMapView)
      return _moduleDefinitions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _logicRules;
  @override
  @JsonKey(name: 'logic_rules')
  Map<String, dynamic>? get logicRules {
    final value = _logicRules;
    if (value == null) return null;
    if (_logicRules is EqualUnmodifiableMapView) return _logicRules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _labelMappings;
  @override
  @JsonKey(name: 'label_mappings')
  Map<String, dynamic>? get labelMappings {
    final value = _labelMappings;
    if (value == null) return null;
    if (_labelMappings is EqualUnmodifiableMapView) return _labelMappings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _permissions;
  @override
  Map<String, dynamic>? get permissions {
    final value = _permissions;
    if (value == null) return null;
    if (_permissions is EqualUnmodifiableMapView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Blueprint(id: $id, name: $name, bpCode: $bpCode, version: $version, uiSchema: $uiSchema, moduleDefinitions: $moduleDefinitions, logicRules: $logicRules, labelMappings: $labelMappings, permissions: $permissions, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlueprintImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.bpCode, bpCode) || other.bpCode == bpCode) &&
            (identical(other.version, version) || other.version == version) &&
            const DeepCollectionEquality().equals(other._uiSchema, _uiSchema) &&
            const DeepCollectionEquality().equals(
              other._moduleDefinitions,
              _moduleDefinitions,
            ) &&
            const DeepCollectionEquality().equals(
              other._logicRules,
              _logicRules,
            ) &&
            const DeepCollectionEquality().equals(
              other._labelMappings,
              _labelMappings,
            ) &&
            const DeepCollectionEquality().equals(
              other._permissions,
              _permissions,
            ) &&
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
    bpCode,
    version,
    const DeepCollectionEquality().hash(_uiSchema),
    const DeepCollectionEquality().hash(_moduleDefinitions),
    const DeepCollectionEquality().hash(_logicRules),
    const DeepCollectionEquality().hash(_labelMappings),
    const DeepCollectionEquality().hash(_permissions),
    createdAt,
    updatedAt,
  );

  /// Create a copy of Blueprint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlueprintImplCopyWith<_$BlueprintImpl> get copyWith =>
      __$$BlueprintImplCopyWithImpl<_$BlueprintImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BlueprintImplToJson(this);
  }
}

abstract class _Blueprint implements Blueprint {
  const factory _Blueprint({
    required final String id,
    required final String name,
    @JsonKey(name: 'bp_code') required final String bpCode,
    required final int version,
    @JsonKey(name: 'ui_schema') final Map<String, dynamic>? uiSchema,
    @JsonKey(name: 'module_definitions')
    final Map<String, dynamic>? moduleDefinitions,
    @JsonKey(name: 'logic_rules') final Map<String, dynamic>? logicRules,
    @JsonKey(name: 'label_mappings') final Map<String, dynamic>? labelMappings,
    final Map<String, dynamic>? permissions,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
  }) = _$BlueprintImpl;

  factory _Blueprint.fromJson(Map<String, dynamic> json) =
      _$BlueprintImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'bp_code')
  String get bpCode;
  @override
  int get version;
  @override
  @JsonKey(name: 'ui_schema')
  Map<String, dynamic>? get uiSchema;
  @override
  @JsonKey(name: 'module_definitions')
  Map<String, dynamic>? get moduleDefinitions;
  @override
  @JsonKey(name: 'logic_rules')
  Map<String, dynamic>? get logicRules;
  @override
  @JsonKey(name: 'label_mappings')
  Map<String, dynamic>? get labelMappings;
  @override
  Map<String, dynamic>? get permissions;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of Blueprint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlueprintImplCopyWith<_$BlueprintImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
