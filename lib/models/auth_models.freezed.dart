// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RequestOTPRequest _$RequestOTPRequestFromJson(Map<String, dynamic> json) {
  return _RequestOTPRequest.fromJson(json);
}

/// @nodoc
mixin _$RequestOTPRequest {
  String get contact => throw _privateConstructorUsedError; // Phone OR Email
  String? get storeCode => throw _privateConstructorUsedError;

  /// Serializes this RequestOTPRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RequestOTPRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequestOTPRequestCopyWith<RequestOTPRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestOTPRequestCopyWith<$Res> {
  factory $RequestOTPRequestCopyWith(
    RequestOTPRequest value,
    $Res Function(RequestOTPRequest) then,
  ) = _$RequestOTPRequestCopyWithImpl<$Res, RequestOTPRequest>;
  @useResult
  $Res call({String contact, String? storeCode});
}

/// @nodoc
class _$RequestOTPRequestCopyWithImpl<$Res, $Val extends RequestOTPRequest>
    implements $RequestOTPRequestCopyWith<$Res> {
  _$RequestOTPRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequestOTPRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? contact = null, Object? storeCode = freezed}) {
    return _then(
      _value.copyWith(
            contact: null == contact
                ? _value.contact
                : contact // ignore: cast_nullable_to_non_nullable
                      as String,
            storeCode: freezed == storeCode
                ? _value.storeCode
                : storeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RequestOTPRequestImplCopyWith<$Res>
    implements $RequestOTPRequestCopyWith<$Res> {
  factory _$$RequestOTPRequestImplCopyWith(
    _$RequestOTPRequestImpl value,
    $Res Function(_$RequestOTPRequestImpl) then,
  ) = __$$RequestOTPRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String contact, String? storeCode});
}

/// @nodoc
class __$$RequestOTPRequestImplCopyWithImpl<$Res>
    extends _$RequestOTPRequestCopyWithImpl<$Res, _$RequestOTPRequestImpl>
    implements _$$RequestOTPRequestImplCopyWith<$Res> {
  __$$RequestOTPRequestImplCopyWithImpl(
    _$RequestOTPRequestImpl _value,
    $Res Function(_$RequestOTPRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestOTPRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? contact = null, Object? storeCode = freezed}) {
    return _then(
      _$RequestOTPRequestImpl(
        contact: null == contact
            ? _value.contact
            : contact // ignore: cast_nullable_to_non_nullable
                  as String,
        storeCode: freezed == storeCode
            ? _value.storeCode
            : storeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestOTPRequestImpl implements _RequestOTPRequest {
  const _$RequestOTPRequestImpl({required this.contact, this.storeCode});

  factory _$RequestOTPRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestOTPRequestImplFromJson(json);

  @override
  final String contact;
  // Phone OR Email
  @override
  final String? storeCode;

  @override
  String toString() {
    return 'RequestOTPRequest(contact: $contact, storeCode: $storeCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestOTPRequestImpl &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.storeCode, storeCode) ||
                other.storeCode == storeCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, contact, storeCode);

  /// Create a copy of RequestOTPRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestOTPRequestImplCopyWith<_$RequestOTPRequestImpl> get copyWith =>
      __$$RequestOTPRequestImplCopyWithImpl<_$RequestOTPRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestOTPRequestImplToJson(this);
  }
}

abstract class _RequestOTPRequest implements RequestOTPRequest {
  const factory _RequestOTPRequest({
    required final String contact,
    final String? storeCode,
  }) = _$RequestOTPRequestImpl;

  factory _RequestOTPRequest.fromJson(Map<String, dynamic> json) =
      _$RequestOTPRequestImpl.fromJson;

  @override
  String get contact; // Phone OR Email
  @override
  String? get storeCode;

  /// Create a copy of RequestOTPRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestOTPRequestImplCopyWith<_$RequestOTPRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VerifyOTPRequest _$VerifyOTPRequestFromJson(Map<String, dynamic> json) {
  return _VerifyOTPRequest.fromJson(json);
}

/// @nodoc
mixin _$VerifyOTPRequest {
  @JsonKey(name: 'otp_token')
  String get otpToken => throw _privateConstructorUsedError; // JWT token from RequestOTP response
  @JsonKey(name: 'otp_code')
  String get otpCode => throw _privateConstructorUsedError;

  /// Serializes this VerifyOTPRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VerifyOTPRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerifyOTPRequestCopyWith<VerifyOTPRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyOTPRequestCopyWith<$Res> {
  factory $VerifyOTPRequestCopyWith(
    VerifyOTPRequest value,
    $Res Function(VerifyOTPRequest) then,
  ) = _$VerifyOTPRequestCopyWithImpl<$Res, VerifyOTPRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'otp_token') String otpToken,
    @JsonKey(name: 'otp_code') String otpCode,
  });
}

/// @nodoc
class _$VerifyOTPRequestCopyWithImpl<$Res, $Val extends VerifyOTPRequest>
    implements $VerifyOTPRequestCopyWith<$Res> {
  _$VerifyOTPRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerifyOTPRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? otpToken = null, Object? otpCode = null}) {
    return _then(
      _value.copyWith(
            otpToken: null == otpToken
                ? _value.otpToken
                : otpToken // ignore: cast_nullable_to_non_nullable
                      as String,
            otpCode: null == otpCode
                ? _value.otpCode
                : otpCode // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VerifyOTPRequestImplCopyWith<$Res>
    implements $VerifyOTPRequestCopyWith<$Res> {
  factory _$$VerifyOTPRequestImplCopyWith(
    _$VerifyOTPRequestImpl value,
    $Res Function(_$VerifyOTPRequestImpl) then,
  ) = __$$VerifyOTPRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'otp_token') String otpToken,
    @JsonKey(name: 'otp_code') String otpCode,
  });
}

/// @nodoc
class __$$VerifyOTPRequestImplCopyWithImpl<$Res>
    extends _$VerifyOTPRequestCopyWithImpl<$Res, _$VerifyOTPRequestImpl>
    implements _$$VerifyOTPRequestImplCopyWith<$Res> {
  __$$VerifyOTPRequestImplCopyWithImpl(
    _$VerifyOTPRequestImpl _value,
    $Res Function(_$VerifyOTPRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VerifyOTPRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? otpToken = null, Object? otpCode = null}) {
    return _then(
      _$VerifyOTPRequestImpl(
        otpToken: null == otpToken
            ? _value.otpToken
            : otpToken // ignore: cast_nullable_to_non_nullable
                  as String,
        otpCode: null == otpCode
            ? _value.otpCode
            : otpCode // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyOTPRequestImpl implements _VerifyOTPRequest {
  const _$VerifyOTPRequestImpl({
    @JsonKey(name: 'otp_token') required this.otpToken,
    @JsonKey(name: 'otp_code') required this.otpCode,
  });

  factory _$VerifyOTPRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyOTPRequestImplFromJson(json);

  @override
  @JsonKey(name: 'otp_token')
  final String otpToken;
  // JWT token from RequestOTP response
  @override
  @JsonKey(name: 'otp_code')
  final String otpCode;

  @override
  String toString() {
    return 'VerifyOTPRequest(otpToken: $otpToken, otpCode: $otpCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyOTPRequestImpl &&
            (identical(other.otpToken, otpToken) ||
                other.otpToken == otpToken) &&
            (identical(other.otpCode, otpCode) || other.otpCode == otpCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, otpToken, otpCode);

  /// Create a copy of VerifyOTPRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyOTPRequestImplCopyWith<_$VerifyOTPRequestImpl> get copyWith =>
      __$$VerifyOTPRequestImplCopyWithImpl<_$VerifyOTPRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyOTPRequestImplToJson(this);
  }
}

abstract class _VerifyOTPRequest implements VerifyOTPRequest {
  const factory _VerifyOTPRequest({
    @JsonKey(name: 'otp_token') required final String otpToken,
    @JsonKey(name: 'otp_code') required final String otpCode,
  }) = _$VerifyOTPRequestImpl;

  factory _VerifyOTPRequest.fromJson(Map<String, dynamic> json) =
      _$VerifyOTPRequestImpl.fromJson;

  @override
  @JsonKey(name: 'otp_token')
  String get otpToken; // JWT token from RequestOTP response
  @override
  @JsonKey(name: 'otp_code')
  String get otpCode;

  /// Create a copy of VerifyOTPRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyOTPRequestImplCopyWith<_$VerifyOTPRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) {
  return _LoginRequest.fromJson(json);
}

/// @nodoc
mixin _$LoginRequest {
  String get contact => throw _privateConstructorUsedError; // Phone OR Email
  String get password => throw _privateConstructorUsedError;
  String? get storeCode => throw _privateConstructorUsedError;

  /// Serializes this LoginRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginRequestCopyWith<LoginRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginRequestCopyWith<$Res> {
  factory $LoginRequestCopyWith(
    LoginRequest value,
    $Res Function(LoginRequest) then,
  ) = _$LoginRequestCopyWithImpl<$Res, LoginRequest>;
  @useResult
  $Res call({String contact, String password, String? storeCode});
}

/// @nodoc
class _$LoginRequestCopyWithImpl<$Res, $Val extends LoginRequest>
    implements $LoginRequestCopyWith<$Res> {
  _$LoginRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = null,
    Object? password = null,
    Object? storeCode = freezed,
  }) {
    return _then(
      _value.copyWith(
            contact: null == contact
                ? _value.contact
                : contact // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
            storeCode: freezed == storeCode
                ? _value.storeCode
                : storeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoginRequestImplCopyWith<$Res>
    implements $LoginRequestCopyWith<$Res> {
  factory _$$LoginRequestImplCopyWith(
    _$LoginRequestImpl value,
    $Res Function(_$LoginRequestImpl) then,
  ) = __$$LoginRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String contact, String password, String? storeCode});
}

/// @nodoc
class __$$LoginRequestImplCopyWithImpl<$Res>
    extends _$LoginRequestCopyWithImpl<$Res, _$LoginRequestImpl>
    implements _$$LoginRequestImplCopyWith<$Res> {
  __$$LoginRequestImplCopyWithImpl(
    _$LoginRequestImpl _value,
    $Res Function(_$LoginRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = null,
    Object? password = null,
    Object? storeCode = freezed,
  }) {
    return _then(
      _$LoginRequestImpl(
        contact: null == contact
            ? _value.contact
            : contact // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
        storeCode: freezed == storeCode
            ? _value.storeCode
            : storeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginRequestImpl implements _LoginRequest {
  const _$LoginRequestImpl({
    required this.contact,
    required this.password,
    this.storeCode,
  });

  factory _$LoginRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginRequestImplFromJson(json);

  @override
  final String contact;
  // Phone OR Email
  @override
  final String password;
  @override
  final String? storeCode;

  @override
  String toString() {
    return 'LoginRequest(contact: $contact, password: $password, storeCode: $storeCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginRequestImpl &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.storeCode, storeCode) ||
                other.storeCode == storeCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, contact, password, storeCode);

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginRequestImplCopyWith<_$LoginRequestImpl> get copyWith =>
      __$$LoginRequestImplCopyWithImpl<_$LoginRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginRequestImplToJson(this);
  }
}

abstract class _LoginRequest implements LoginRequest {
  const factory _LoginRequest({
    required final String contact,
    required final String password,
    final String? storeCode,
  }) = _$LoginRequestImpl;

  factory _LoginRequest.fromJson(Map<String, dynamic> json) =
      _$LoginRequestImpl.fromJson;

  @override
  String get contact; // Phone OR Email
  @override
  String get password;
  @override
  String? get storeCode;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginRequestImplCopyWith<_$LoginRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoginTerminalRequest _$LoginTerminalRequestFromJson(Map<String, dynamic> json) {
  return _LoginTerminalRequest.fromJson(json);
}

/// @nodoc
mixin _$LoginTerminalRequest {
  String get phone => throw _privateConstructorUsedError;
  String get storeCode => throw _privateConstructorUsedError;
  String get pin => throw _privateConstructorUsedError;

  /// Serializes this LoginTerminalRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginTerminalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginTerminalRequestCopyWith<LoginTerminalRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginTerminalRequestCopyWith<$Res> {
  factory $LoginTerminalRequestCopyWith(
    LoginTerminalRequest value,
    $Res Function(LoginTerminalRequest) then,
  ) = _$LoginTerminalRequestCopyWithImpl<$Res, LoginTerminalRequest>;
  @useResult
  $Res call({String phone, String storeCode, String pin});
}

/// @nodoc
class _$LoginTerminalRequestCopyWithImpl<
  $Res,
  $Val extends LoginTerminalRequest
>
    implements $LoginTerminalRequestCopyWith<$Res> {
  _$LoginTerminalRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginTerminalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? storeCode = null,
    Object? pin = null,
  }) {
    return _then(
      _value.copyWith(
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            storeCode: null == storeCode
                ? _value.storeCode
                : storeCode // ignore: cast_nullable_to_non_nullable
                      as String,
            pin: null == pin
                ? _value.pin
                : pin // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoginTerminalRequestImplCopyWith<$Res>
    implements $LoginTerminalRequestCopyWith<$Res> {
  factory _$$LoginTerminalRequestImplCopyWith(
    _$LoginTerminalRequestImpl value,
    $Res Function(_$LoginTerminalRequestImpl) then,
  ) = __$$LoginTerminalRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String phone, String storeCode, String pin});
}

/// @nodoc
class __$$LoginTerminalRequestImplCopyWithImpl<$Res>
    extends _$LoginTerminalRequestCopyWithImpl<$Res, _$LoginTerminalRequestImpl>
    implements _$$LoginTerminalRequestImplCopyWith<$Res> {
  __$$LoginTerminalRequestImplCopyWithImpl(
    _$LoginTerminalRequestImpl _value,
    $Res Function(_$LoginTerminalRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginTerminalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? storeCode = null,
    Object? pin = null,
  }) {
    return _then(
      _$LoginTerminalRequestImpl(
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        storeCode: null == storeCode
            ? _value.storeCode
            : storeCode // ignore: cast_nullable_to_non_nullable
                  as String,
        pin: null == pin
            ? _value.pin
            : pin // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginTerminalRequestImpl implements _LoginTerminalRequest {
  const _$LoginTerminalRequestImpl({
    required this.phone,
    required this.storeCode,
    required this.pin,
  });

  factory _$LoginTerminalRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginTerminalRequestImplFromJson(json);

  @override
  final String phone;
  @override
  final String storeCode;
  @override
  final String pin;

  @override
  String toString() {
    return 'LoginTerminalRequest(phone: $phone, storeCode: $storeCode, pin: $pin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginTerminalRequestImpl &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.storeCode, storeCode) ||
                other.storeCode == storeCode) &&
            (identical(other.pin, pin) || other.pin == pin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phone, storeCode, pin);

  /// Create a copy of LoginTerminalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginTerminalRequestImplCopyWith<_$LoginTerminalRequestImpl>
  get copyWith =>
      __$$LoginTerminalRequestImplCopyWithImpl<_$LoginTerminalRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginTerminalRequestImplToJson(this);
  }
}

abstract class _LoginTerminalRequest implements LoginTerminalRequest {
  const factory _LoginTerminalRequest({
    required final String phone,
    required final String storeCode,
    required final String pin,
  }) = _$LoginTerminalRequestImpl;

  factory _LoginTerminalRequest.fromJson(Map<String, dynamic> json) =
      _$LoginTerminalRequestImpl.fromJson;

  @override
  String get phone;
  @override
  String get storeCode;
  @override
  String get pin;

  /// Create a copy of LoginTerminalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginTerminalRequestImplCopyWith<_$LoginTerminalRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CreateUserRequest _$CreateUserRequestFromJson(Map<String, dynamic> json) {
  return _CreateUserRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateUserRequest {
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_number')
  String? get phoneNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'password')
  String? get password => throw _privateConstructorUsedError;

  /// Serializes this CreateUserRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateUserRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateUserRequestCopyWith<CreateUserRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateUserRequestCopyWith<$Res> {
  factory $CreateUserRequestCopyWith(
    CreateUserRequest value,
    $Res Function(CreateUserRequest) then,
  ) = _$CreateUserRequestCopyWithImpl<$Res, CreateUserRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'full_name') String fullName,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'password') String? password,
  });
}

/// @nodoc
class _$CreateUserRequestCopyWithImpl<$Res, $Val extends CreateUserRequest>
    implements $CreateUserRequestCopyWith<$Res> {
  _$CreateUserRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateUserRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? phoneNumber = freezed,
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(
      _value.copyWith(
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            password: freezed == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateUserRequestImplCopyWith<$Res>
    implements $CreateUserRequestCopyWith<$Res> {
  factory _$$CreateUserRequestImplCopyWith(
    _$CreateUserRequestImpl value,
    $Res Function(_$CreateUserRequestImpl) then,
  ) = __$$CreateUserRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'full_name') String fullName,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'password') String? password,
  });
}

/// @nodoc
class __$$CreateUserRequestImplCopyWithImpl<$Res>
    extends _$CreateUserRequestCopyWithImpl<$Res, _$CreateUserRequestImpl>
    implements _$$CreateUserRequestImplCopyWith<$Res> {
  __$$CreateUserRequestImplCopyWithImpl(
    _$CreateUserRequestImpl _value,
    $Res Function(_$CreateUserRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateUserRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? phoneNumber = freezed,
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(
      _$CreateUserRequestImpl(
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        password: freezed == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateUserRequestImpl implements _CreateUserRequest {
  const _$CreateUserRequestImpl({
    @JsonKey(name: 'full_name') required this.fullName,
    @JsonKey(name: 'phone_number') this.phoneNumber,
    @JsonKey(name: 'email') this.email,
    @JsonKey(name: 'password') this.password,
  });

  factory _$CreateUserRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateUserRequestImplFromJson(json);

  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @override
  @JsonKey(name: 'email')
  final String? email;
  @override
  @JsonKey(name: 'password')
  final String? password;

  @override
  String toString() {
    return 'CreateUserRequest(fullName: $fullName, phoneNumber: $phoneNumber, email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateUserRequestImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, fullName, phoneNumber, email, password);

  /// Create a copy of CreateUserRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateUserRequestImplCopyWith<_$CreateUserRequestImpl> get copyWith =>
      __$$CreateUserRequestImplCopyWithImpl<_$CreateUserRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateUserRequestImplToJson(this);
  }
}

abstract class _CreateUserRequest implements CreateUserRequest {
  const factory _CreateUserRequest({
    @JsonKey(name: 'full_name') required final String fullName,
    @JsonKey(name: 'phone_number') final String? phoneNumber,
    @JsonKey(name: 'email') final String? email,
    @JsonKey(name: 'password') final String? password,
  }) = _$CreateUserRequestImpl;

  factory _CreateUserRequest.fromJson(Map<String, dynamic> json) =
      _$CreateUserRequestImpl.fromJson;

  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  @JsonKey(name: 'phone_number')
  String? get phoneNumber;
  @override
  @JsonKey(name: 'email')
  String? get email;
  @override
  @JsonKey(name: 'password')
  String? get password;

  /// Create a copy of CreateUserRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateUserRequestImplCopyWith<_$CreateUserRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SignUpRequest _$SignUpRequestFromJson(Map<String, dynamic> json) {
  return _SignUpRequest.fromJson(json);
}

/// @nodoc
mixin _$SignUpRequest {
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_number')
  String? get phoneNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'password')
  String? get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_name')
  String get businessName => throw _privateConstructorUsedError;
  @JsonKey(name: 'blueprint_id')
  String get blueprintId => throw _privateConstructorUsedError;

  /// Serializes this SignUpRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SignUpRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignUpRequestCopyWith<SignUpRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpRequestCopyWith<$Res> {
  factory $SignUpRequestCopyWith(
    SignUpRequest value,
    $Res Function(SignUpRequest) then,
  ) = _$SignUpRequestCopyWithImpl<$Res, SignUpRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'full_name') String fullName,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'password') String? password,
    @JsonKey(name: 'business_name') String businessName,
    @JsonKey(name: 'blueprint_id') String blueprintId,
  });
}

/// @nodoc
class _$SignUpRequestCopyWithImpl<$Res, $Val extends SignUpRequest>
    implements $SignUpRequestCopyWith<$Res> {
  _$SignUpRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignUpRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? phoneNumber = freezed,
    Object? email = freezed,
    Object? password = freezed,
    Object? businessName = null,
    Object? blueprintId = null,
  }) {
    return _then(
      _value.copyWith(
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            password: freezed == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String?,
            businessName: null == businessName
                ? _value.businessName
                : businessName // ignore: cast_nullable_to_non_nullable
                      as String,
            blueprintId: null == blueprintId
                ? _value.blueprintId
                : blueprintId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SignUpRequestImplCopyWith<$Res>
    implements $SignUpRequestCopyWith<$Res> {
  factory _$$SignUpRequestImplCopyWith(
    _$SignUpRequestImpl value,
    $Res Function(_$SignUpRequestImpl) then,
  ) = __$$SignUpRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'full_name') String fullName,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'password') String? password,
    @JsonKey(name: 'business_name') String businessName,
    @JsonKey(name: 'blueprint_id') String blueprintId,
  });
}

/// @nodoc
class __$$SignUpRequestImplCopyWithImpl<$Res>
    extends _$SignUpRequestCopyWithImpl<$Res, _$SignUpRequestImpl>
    implements _$$SignUpRequestImplCopyWith<$Res> {
  __$$SignUpRequestImplCopyWithImpl(
    _$SignUpRequestImpl _value,
    $Res Function(_$SignUpRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SignUpRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? phoneNumber = freezed,
    Object? email = freezed,
    Object? password = freezed,
    Object? businessName = null,
    Object? blueprintId = null,
  }) {
    return _then(
      _$SignUpRequestImpl(
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        password: freezed == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String?,
        businessName: null == businessName
            ? _value.businessName
            : businessName // ignore: cast_nullable_to_non_nullable
                  as String,
        blueprintId: null == blueprintId
            ? _value.blueprintId
            : blueprintId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SignUpRequestImpl implements _SignUpRequest {
  const _$SignUpRequestImpl({
    @JsonKey(name: 'full_name') required this.fullName,
    @JsonKey(name: 'phone_number') this.phoneNumber,
    @JsonKey(name: 'email') this.email,
    @JsonKey(name: 'password') this.password,
    @JsonKey(name: 'business_name') required this.businessName,
    @JsonKey(name: 'blueprint_id') required this.blueprintId,
  });

  factory _$SignUpRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignUpRequestImplFromJson(json);

  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @override
  @JsonKey(name: 'email')
  final String? email;
  @override
  @JsonKey(name: 'password')
  final String? password;
  @override
  @JsonKey(name: 'business_name')
  final String businessName;
  @override
  @JsonKey(name: 'blueprint_id')
  final String blueprintId;

  @override
  String toString() {
    return 'SignUpRequest(fullName: $fullName, phoneNumber: $phoneNumber, email: $email, password: $password, businessName: $businessName, blueprintId: $blueprintId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpRequestImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.businessName, businessName) ||
                other.businessName == businessName) &&
            (identical(other.blueprintId, blueprintId) ||
                other.blueprintId == blueprintId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    fullName,
    phoneNumber,
    email,
    password,
    businessName,
    blueprintId,
  );

  /// Create a copy of SignUpRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpRequestImplCopyWith<_$SignUpRequestImpl> get copyWith =>
      __$$SignUpRequestImplCopyWithImpl<_$SignUpRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignUpRequestImplToJson(this);
  }
}

abstract class _SignUpRequest implements SignUpRequest {
  const factory _SignUpRequest({
    @JsonKey(name: 'full_name') required final String fullName,
    @JsonKey(name: 'phone_number') final String? phoneNumber,
    @JsonKey(name: 'email') final String? email,
    @JsonKey(name: 'password') final String? password,
    @JsonKey(name: 'business_name') required final String businessName,
    @JsonKey(name: 'blueprint_id') required final String blueprintId,
  }) = _$SignUpRequestImpl;

  factory _SignUpRequest.fromJson(Map<String, dynamic> json) =
      _$SignUpRequestImpl.fromJson;

  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  @JsonKey(name: 'phone_number')
  String? get phoneNumber;
  @override
  @JsonKey(name: 'email')
  String? get email;
  @override
  @JsonKey(name: 'password')
  String? get password;
  @override
  @JsonKey(name: 'business_name')
  String get businessName;
  @override
  @JsonKey(name: 'blueprint_id')
  String get blueprintId;

  /// Create a copy of SignUpRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignUpRequestImplCopyWith<_$SignUpRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RequestOTPResponse _$RequestOTPResponseFromJson(Map<String, dynamic> json) {
  return _RequestOTPResponse.fromJson(json);
}

/// @nodoc
mixin _$RequestOTPResponse {
  @JsonKey(name: 'otp_token')
  String get otpToken => throw _privateConstructorUsedError; // Stateless JWT containing hashed code
  @JsonKey(name: 'expires_at')
  DateTime get expiresAt => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this RequestOTPResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RequestOTPResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequestOTPResponseCopyWith<RequestOTPResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestOTPResponseCopyWith<$Res> {
  factory $RequestOTPResponseCopyWith(
    RequestOTPResponse value,
    $Res Function(RequestOTPResponse) then,
  ) = _$RequestOTPResponseCopyWithImpl<$Res, RequestOTPResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'otp_token') String otpToken,
    @JsonKey(name: 'expires_at') DateTime expiresAt,
    String message,
  });
}

/// @nodoc
class _$RequestOTPResponseCopyWithImpl<$Res, $Val extends RequestOTPResponse>
    implements $RequestOTPResponseCopyWith<$Res> {
  _$RequestOTPResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequestOTPResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otpToken = null,
    Object? expiresAt = null,
    Object? message = null,
  }) {
    return _then(
      _value.copyWith(
            otpToken: null == otpToken
                ? _value.otpToken
                : otpToken // ignore: cast_nullable_to_non_nullable
                      as String,
            expiresAt: null == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RequestOTPResponseImplCopyWith<$Res>
    implements $RequestOTPResponseCopyWith<$Res> {
  factory _$$RequestOTPResponseImplCopyWith(
    _$RequestOTPResponseImpl value,
    $Res Function(_$RequestOTPResponseImpl) then,
  ) = __$$RequestOTPResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'otp_token') String otpToken,
    @JsonKey(name: 'expires_at') DateTime expiresAt,
    String message,
  });
}

/// @nodoc
class __$$RequestOTPResponseImplCopyWithImpl<$Res>
    extends _$RequestOTPResponseCopyWithImpl<$Res, _$RequestOTPResponseImpl>
    implements _$$RequestOTPResponseImplCopyWith<$Res> {
  __$$RequestOTPResponseImplCopyWithImpl(
    _$RequestOTPResponseImpl _value,
    $Res Function(_$RequestOTPResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestOTPResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otpToken = null,
    Object? expiresAt = null,
    Object? message = null,
  }) {
    return _then(
      _$RequestOTPResponseImpl(
        otpToken: null == otpToken
            ? _value.otpToken
            : otpToken // ignore: cast_nullable_to_non_nullable
                  as String,
        expiresAt: null == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestOTPResponseImpl implements _RequestOTPResponse {
  const _$RequestOTPResponseImpl({
    @JsonKey(name: 'otp_token') required this.otpToken,
    @JsonKey(name: 'expires_at') required this.expiresAt,
    required this.message,
  });

  factory _$RequestOTPResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestOTPResponseImplFromJson(json);

  @override
  @JsonKey(name: 'otp_token')
  final String otpToken;
  // Stateless JWT containing hashed code
  @override
  @JsonKey(name: 'expires_at')
  final DateTime expiresAt;
  @override
  final String message;

  @override
  String toString() {
    return 'RequestOTPResponse(otpToken: $otpToken, expiresAt: $expiresAt, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestOTPResponseImpl &&
            (identical(other.otpToken, otpToken) ||
                other.otpToken == otpToken) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, otpToken, expiresAt, message);

  /// Create a copy of RequestOTPResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestOTPResponseImplCopyWith<_$RequestOTPResponseImpl> get copyWith =>
      __$$RequestOTPResponseImplCopyWithImpl<_$RequestOTPResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestOTPResponseImplToJson(this);
  }
}

abstract class _RequestOTPResponse implements RequestOTPResponse {
  const factory _RequestOTPResponse({
    @JsonKey(name: 'otp_token') required final String otpToken,
    @JsonKey(name: 'expires_at') required final DateTime expiresAt,
    required final String message,
  }) = _$RequestOTPResponseImpl;

  factory _RequestOTPResponse.fromJson(Map<String, dynamic> json) =
      _$RequestOTPResponseImpl.fromJson;

  @override
  @JsonKey(name: 'otp_token')
  String get otpToken; // Stateless JWT containing hashed code
  @override
  @JsonKey(name: 'expires_at')
  DateTime get expiresAt;
  @override
  String get message;

  /// Create a copy of RequestOTPResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestOTPResponseImplCopyWith<_$RequestOTPResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return _LoginResponse.fromJson(json);
}

/// @nodoc
mixin _$LoginResponse {
  String get token => throw _privateConstructorUsedError;
  @JsonKey(name: 'csrf_token')
  String? get csrfToken => throw _privateConstructorUsedError; // Only for web clients
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_type')
  String get userType => throw _privateConstructorUsedError; // "admin" or "staff"
  @JsonKey(name: 'business_id')
  String? get businessId => throw _privateConstructorUsedError; // For staff type
  @JsonKey(name: 'store_code')
  String? get storeCode => throw _privateConstructorUsedError; // For staff type
  String? get role => throw _privateConstructorUsedError; // For staff type
  List<BusinessRole>? get businesses =>
      throw _privateConstructorUsedError; // For admin type
  @JsonKey(name: 'expires_at')
  DateTime get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this LoginResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginResponseCopyWith<LoginResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginResponseCopyWith<$Res> {
  factory $LoginResponseCopyWith(
    LoginResponse value,
    $Res Function(LoginResponse) then,
  ) = _$LoginResponseCopyWithImpl<$Res, LoginResponse>;
  @useResult
  $Res call({
    String token,
    @JsonKey(name: 'csrf_token') String? csrfToken,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'user_type') String userType,
    @JsonKey(name: 'business_id') String? businessId,
    @JsonKey(name: 'store_code') String? storeCode,
    String? role,
    List<BusinessRole>? businesses,
    @JsonKey(name: 'expires_at') DateTime expiresAt,
  });
}

/// @nodoc
class _$LoginResponseCopyWithImpl<$Res, $Val extends LoginResponse>
    implements $LoginResponseCopyWith<$Res> {
  _$LoginResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? csrfToken = freezed,
    Object? userId = null,
    Object? userType = null,
    Object? businessId = freezed,
    Object? storeCode = freezed,
    Object? role = freezed,
    Object? businesses = freezed,
    Object? expiresAt = null,
  }) {
    return _then(
      _value.copyWith(
            token: null == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String,
            csrfToken: freezed == csrfToken
                ? _value.csrfToken
                : csrfToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            userType: null == userType
                ? _value.userType
                : userType // ignore: cast_nullable_to_non_nullable
                      as String,
            businessId: freezed == businessId
                ? _value.businessId
                : businessId // ignore: cast_nullable_to_non_nullable
                      as String?,
            storeCode: freezed == storeCode
                ? _value.storeCode
                : storeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            role: freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String?,
            businesses: freezed == businesses
                ? _value.businesses
                : businesses // ignore: cast_nullable_to_non_nullable
                      as List<BusinessRole>?,
            expiresAt: null == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoginResponseImplCopyWith<$Res>
    implements $LoginResponseCopyWith<$Res> {
  factory _$$LoginResponseImplCopyWith(
    _$LoginResponseImpl value,
    $Res Function(_$LoginResponseImpl) then,
  ) = __$$LoginResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String token,
    @JsonKey(name: 'csrf_token') String? csrfToken,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'user_type') String userType,
    @JsonKey(name: 'business_id') String? businessId,
    @JsonKey(name: 'store_code') String? storeCode,
    String? role,
    List<BusinessRole>? businesses,
    @JsonKey(name: 'expires_at') DateTime expiresAt,
  });
}

/// @nodoc
class __$$LoginResponseImplCopyWithImpl<$Res>
    extends _$LoginResponseCopyWithImpl<$Res, _$LoginResponseImpl>
    implements _$$LoginResponseImplCopyWith<$Res> {
  __$$LoginResponseImplCopyWithImpl(
    _$LoginResponseImpl _value,
    $Res Function(_$LoginResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? csrfToken = freezed,
    Object? userId = null,
    Object? userType = null,
    Object? businessId = freezed,
    Object? storeCode = freezed,
    Object? role = freezed,
    Object? businesses = freezed,
    Object? expiresAt = null,
  }) {
    return _then(
      _$LoginResponseImpl(
        token: null == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String,
        csrfToken: freezed == csrfToken
            ? _value.csrfToken
            : csrfToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        userType: null == userType
            ? _value.userType
            : userType // ignore: cast_nullable_to_non_nullable
                  as String,
        businessId: freezed == businessId
            ? _value.businessId
            : businessId // ignore: cast_nullable_to_non_nullable
                  as String?,
        storeCode: freezed == storeCode
            ? _value.storeCode
            : storeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: freezed == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String?,
        businesses: freezed == businesses
            ? _value._businesses
            : businesses // ignore: cast_nullable_to_non_nullable
                  as List<BusinessRole>?,
        expiresAt: null == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginResponseImpl implements _LoginResponse {
  const _$LoginResponseImpl({
    required this.token,
    @JsonKey(name: 'csrf_token') this.csrfToken,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'user_type') required this.userType,
    @JsonKey(name: 'business_id') this.businessId,
    @JsonKey(name: 'store_code') this.storeCode,
    this.role,
    final List<BusinessRole>? businesses,
    @JsonKey(name: 'expires_at') required this.expiresAt,
  }) : _businesses = businesses;

  factory _$LoginResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginResponseImplFromJson(json);

  @override
  final String token;
  @override
  @JsonKey(name: 'csrf_token')
  final String? csrfToken;
  // Only for web clients
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'user_type')
  final String userType;
  // "admin" or "staff"
  @override
  @JsonKey(name: 'business_id')
  final String? businessId;
  // For staff type
  @override
  @JsonKey(name: 'store_code')
  final String? storeCode;
  // For staff type
  @override
  final String? role;
  // For staff type
  final List<BusinessRole>? _businesses;
  // For staff type
  @override
  List<BusinessRole>? get businesses {
    final value = _businesses;
    if (value == null) return null;
    if (_businesses is EqualUnmodifiableListView) return _businesses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // For admin type
  @override
  @JsonKey(name: 'expires_at')
  final DateTime expiresAt;

  @override
  String toString() {
    return 'LoginResponse(token: $token, csrfToken: $csrfToken, userId: $userId, userType: $userType, businessId: $businessId, storeCode: $storeCode, role: $role, businesses: $businesses, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginResponseImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.csrfToken, csrfToken) ||
                other.csrfToken == csrfToken) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.storeCode, storeCode) ||
                other.storeCode == storeCode) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality().equals(
              other._businesses,
              _businesses,
            ) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    token,
    csrfToken,
    userId,
    userType,
    businessId,
    storeCode,
    role,
    const DeepCollectionEquality().hash(_businesses),
    expiresAt,
  );

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginResponseImplCopyWith<_$LoginResponseImpl> get copyWith =>
      __$$LoginResponseImplCopyWithImpl<_$LoginResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginResponseImplToJson(this);
  }
}

abstract class _LoginResponse implements LoginResponse {
  const factory _LoginResponse({
    required final String token,
    @JsonKey(name: 'csrf_token') final String? csrfToken,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'user_type') required final String userType,
    @JsonKey(name: 'business_id') final String? businessId,
    @JsonKey(name: 'store_code') final String? storeCode,
    final String? role,
    final List<BusinessRole>? businesses,
    @JsonKey(name: 'expires_at') required final DateTime expiresAt,
  }) = _$LoginResponseImpl;

  factory _LoginResponse.fromJson(Map<String, dynamic> json) =
      _$LoginResponseImpl.fromJson;

  @override
  String get token;
  @override
  @JsonKey(name: 'csrf_token')
  String? get csrfToken; // Only for web clients
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'user_type')
  String get userType; // "admin" or "staff"
  @override
  @JsonKey(name: 'business_id')
  String? get businessId; // For staff type
  @override
  @JsonKey(name: 'store_code')
  String? get storeCode; // For staff type
  @override
  String? get role; // For staff type
  @override
  List<BusinessRole>? get businesses; // For admin type
  @override
  @JsonKey(name: 'expires_at')
  DateTime get expiresAt;

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginResponseImplCopyWith<_$LoginResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BusinessRole _$BusinessRoleFromJson(Map<String, dynamic> json) {
  return _BusinessRole.fromJson(json);
}

/// @nodoc
mixin _$BusinessRole {
  @JsonKey(name: 'business_id')
  String get businessId => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_code')
  String get storeCode => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;

  /// Serializes this BusinessRole to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessRole
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessRoleCopyWith<BusinessRole> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessRoleCopyWith<$Res> {
  factory $BusinessRoleCopyWith(
    BusinessRole value,
    $Res Function(BusinessRole) then,
  ) = _$BusinessRoleCopyWithImpl<$Res, BusinessRole>;
  @useResult
  $Res call({
    @JsonKey(name: 'business_id') String businessId,
    @JsonKey(name: 'store_code') String storeCode,
    String role,
  });
}

/// @nodoc
class _$BusinessRoleCopyWithImpl<$Res, $Val extends BusinessRole>
    implements $BusinessRoleCopyWith<$Res> {
  _$BusinessRoleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessRole
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? businessId = null,
    Object? storeCode = null,
    Object? role = null,
  }) {
    return _then(
      _value.copyWith(
            businessId: null == businessId
                ? _value.businessId
                : businessId // ignore: cast_nullable_to_non_nullable
                      as String,
            storeCode: null == storeCode
                ? _value.storeCode
                : storeCode // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BusinessRoleImplCopyWith<$Res>
    implements $BusinessRoleCopyWith<$Res> {
  factory _$$BusinessRoleImplCopyWith(
    _$BusinessRoleImpl value,
    $Res Function(_$BusinessRoleImpl) then,
  ) = __$$BusinessRoleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'business_id') String businessId,
    @JsonKey(name: 'store_code') String storeCode,
    String role,
  });
}

/// @nodoc
class __$$BusinessRoleImplCopyWithImpl<$Res>
    extends _$BusinessRoleCopyWithImpl<$Res, _$BusinessRoleImpl>
    implements _$$BusinessRoleImplCopyWith<$Res> {
  __$$BusinessRoleImplCopyWithImpl(
    _$BusinessRoleImpl _value,
    $Res Function(_$BusinessRoleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusinessRole
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? businessId = null,
    Object? storeCode = null,
    Object? role = null,
  }) {
    return _then(
      _$BusinessRoleImpl(
        businessId: null == businessId
            ? _value.businessId
            : businessId // ignore: cast_nullable_to_non_nullable
                  as String,
        storeCode: null == storeCode
            ? _value.storeCode
            : storeCode // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessRoleImpl implements _BusinessRole {
  const _$BusinessRoleImpl({
    @JsonKey(name: 'business_id') required this.businessId,
    @JsonKey(name: 'store_code') required this.storeCode,
    required this.role,
  });

  factory _$BusinessRoleImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessRoleImplFromJson(json);

  @override
  @JsonKey(name: 'business_id')
  final String businessId;
  @override
  @JsonKey(name: 'store_code')
  final String storeCode;
  @override
  final String role;

  @override
  String toString() {
    return 'BusinessRole(businessId: $businessId, storeCode: $storeCode, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessRoleImpl &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.storeCode, storeCode) ||
                other.storeCode == storeCode) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, businessId, storeCode, role);

  /// Create a copy of BusinessRole
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessRoleImplCopyWith<_$BusinessRoleImpl> get copyWith =>
      __$$BusinessRoleImplCopyWithImpl<_$BusinessRoleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessRoleImplToJson(this);
  }
}

abstract class _BusinessRole implements BusinessRole {
  const factory _BusinessRole({
    @JsonKey(name: 'business_id') required final String businessId,
    @JsonKey(name: 'store_code') required final String storeCode,
    required final String role,
  }) = _$BusinessRoleImpl;

  factory _BusinessRole.fromJson(Map<String, dynamic> json) =
      _$BusinessRoleImpl.fromJson;

  @override
  @JsonKey(name: 'business_id')
  String get businessId;
  @override
  @JsonKey(name: 'store_code')
  String get storeCode;
  @override
  String get role;

  /// Create a copy of BusinessRole
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessRoleImplCopyWith<_$BusinessRoleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_number')
  String? get phoneNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_verified')
  bool get isVerified => throw _privateConstructorUsedError;
  @JsonKey(name: 'version')
  int get version => throw _privateConstructorUsedError; // Optimistic locking version
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'full_name') String fullName,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'is_verified') bool isVerified,
    @JsonKey(name: 'version') int version,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? phoneNumber = freezed,
    Object? email = freezed,
    Object? isVerified = null,
    Object? version = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            isVerified: null == isVerified
                ? _value.isVerified
                : isVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            version: null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
    _$UserImpl value,
    $Res Function(_$UserImpl) then,
  ) = __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'full_name') String fullName,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'is_verified') bool isVerified,
    @JsonKey(name: 'version') int version,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
    : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? phoneNumber = freezed,
    Object? email = freezed,
    Object? isVerified = null,
    Object? version = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$UserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        isVerified: null == isVerified
            ? _value.isVerified
            : isVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'full_name') required this.fullName,
    @JsonKey(name: 'phone_number') this.phoneNumber,
    @JsonKey(name: 'email') this.email,
    @JsonKey(name: 'is_verified') required this.isVerified,
    @JsonKey(name: 'version') this.version = 1,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @override
  @JsonKey(name: 'email')
  final String? email;
  @override
  @JsonKey(name: 'is_verified')
  final bool isVerified;
  @override
  @JsonKey(name: 'version')
  final int version;
  // Optimistic locking version
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'User(id: $id, fullName: $fullName, phoneNumber: $phoneNumber, email: $email, isVerified: $isVerified, version: $version, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fullName,
    phoneNumber,
    email,
    isVerified,
    version,
    createdAt,
  );

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(this);
  }
}

abstract class _User implements User {
  const factory _User({
    @JsonKey(name: 'id') required final String id,
    @JsonKey(name: 'full_name') required final String fullName,
    @JsonKey(name: 'phone_number') final String? phoneNumber,
    @JsonKey(name: 'email') final String? email,
    @JsonKey(name: 'is_verified') required final bool isVerified,
    @JsonKey(name: 'version') final int version,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
  }) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  @JsonKey(name: 'phone_number')
  String? get phoneNumber;
  @override
  @JsonKey(name: 'email')
  String? get email;
  @override
  @JsonKey(name: 'is_verified')
  bool get isVerified;
  @override
  @JsonKey(name: 'version')
  int get version; // Optimistic locking version
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SignUpResponse _$SignUpResponseFromJson(Map<String, dynamic> json) {
  return _SignUpResponse.fromJson(json);
}

/// @nodoc
mixin _$SignUpResponse {
  User get user => throw _privateConstructorUsedError;
  Business get business => throw _privateConstructorUsedError;

  /// Serializes this SignUpResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SignUpResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignUpResponseCopyWith<SignUpResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpResponseCopyWith<$Res> {
  factory $SignUpResponseCopyWith(
    SignUpResponse value,
    $Res Function(SignUpResponse) then,
  ) = _$SignUpResponseCopyWithImpl<$Res, SignUpResponse>;
  @useResult
  $Res call({User user, Business business});

  $UserCopyWith<$Res> get user;
  $BusinessCopyWith<$Res> get business;
}

/// @nodoc
class _$SignUpResponseCopyWithImpl<$Res, $Val extends SignUpResponse>
    implements $SignUpResponseCopyWith<$Res> {
  _$SignUpResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignUpResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? user = null, Object? business = null}) {
    return _then(
      _value.copyWith(
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as User,
            business: null == business
                ? _value.business
                : business // ignore: cast_nullable_to_non_nullable
                      as Business,
          )
          as $Val,
    );
  }

  /// Create a copy of SignUpResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of SignUpResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BusinessCopyWith<$Res> get business {
    return $BusinessCopyWith<$Res>(_value.business, (value) {
      return _then(_value.copyWith(business: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SignUpResponseImplCopyWith<$Res>
    implements $SignUpResponseCopyWith<$Res> {
  factory _$$SignUpResponseImplCopyWith(
    _$SignUpResponseImpl value,
    $Res Function(_$SignUpResponseImpl) then,
  ) = __$$SignUpResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({User user, Business business});

  @override
  $UserCopyWith<$Res> get user;
  @override
  $BusinessCopyWith<$Res> get business;
}

/// @nodoc
class __$$SignUpResponseImplCopyWithImpl<$Res>
    extends _$SignUpResponseCopyWithImpl<$Res, _$SignUpResponseImpl>
    implements _$$SignUpResponseImplCopyWith<$Res> {
  __$$SignUpResponseImplCopyWithImpl(
    _$SignUpResponseImpl _value,
    $Res Function(_$SignUpResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SignUpResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? user = null, Object? business = null}) {
    return _then(
      _$SignUpResponseImpl(
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as User,
        business: null == business
            ? _value.business
            : business // ignore: cast_nullable_to_non_nullable
                  as Business,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SignUpResponseImpl implements _SignUpResponse {
  const _$SignUpResponseImpl({required this.user, required this.business});

  factory _$SignUpResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignUpResponseImplFromJson(json);

  @override
  final User user;
  @override
  final Business business;

  @override
  String toString() {
    return 'SignUpResponse(user: $user, business: $business)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpResponseImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.business, business) ||
                other.business == business));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user, business);

  /// Create a copy of SignUpResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpResponseImplCopyWith<_$SignUpResponseImpl> get copyWith =>
      __$$SignUpResponseImplCopyWithImpl<_$SignUpResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SignUpResponseImplToJson(this);
  }
}

abstract class _SignUpResponse implements SignUpResponse {
  const factory _SignUpResponse({
    required final User user,
    required final Business business,
  }) = _$SignUpResponseImpl;

  factory _SignUpResponse.fromJson(Map<String, dynamic> json) =
      _$SignUpResponseImpl.fromJson;

  @override
  User get user;
  @override
  Business get business;

  /// Create a copy of SignUpResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignUpResponseImplCopyWith<_$SignUpResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AssignBusinessRoleRequest _$AssignBusinessRoleRequestFromJson(
  Map<String, dynamic> json,
) {
  return _AssignBusinessRoleRequest.fromJson(json);
}

/// @nodoc
mixin _$AssignBusinessRoleRequest {
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_number')
  String get phoneNumber => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'terminal_pin')
  String? get terminalPin => throw _privateConstructorUsedError;

  /// Serializes this AssignBusinessRoleRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssignBusinessRoleRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssignBusinessRoleRequestCopyWith<AssignBusinessRoleRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssignBusinessRoleRequestCopyWith<$Res> {
  factory $AssignBusinessRoleRequestCopyWith(
    AssignBusinessRoleRequest value,
    $Res Function(AssignBusinessRoleRequest) then,
  ) = _$AssignBusinessRoleRequestCopyWithImpl<$Res, AssignBusinessRoleRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'full_name') String fullName,
    String email,
    @JsonKey(name: 'phone_number') String phoneNumber,
    String role,
    String? password,
    @JsonKey(name: 'terminal_pin') String? terminalPin,
  });
}

/// @nodoc
class _$AssignBusinessRoleRequestCopyWithImpl<
  $Res,
  $Val extends AssignBusinessRoleRequest
>
    implements $AssignBusinessRoleRequestCopyWith<$Res> {
  _$AssignBusinessRoleRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssignBusinessRoleRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? phoneNumber = null,
    Object? role = null,
    Object? password = freezed,
    Object? terminalPin = freezed,
  }) {
    return _then(
      _value.copyWith(
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNumber: null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            password: freezed == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String?,
            terminalPin: freezed == terminalPin
                ? _value.terminalPin
                : terminalPin // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AssignBusinessRoleRequestImplCopyWith<$Res>
    implements $AssignBusinessRoleRequestCopyWith<$Res> {
  factory _$$AssignBusinessRoleRequestImplCopyWith(
    _$AssignBusinessRoleRequestImpl value,
    $Res Function(_$AssignBusinessRoleRequestImpl) then,
  ) = __$$AssignBusinessRoleRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'full_name') String fullName,
    String email,
    @JsonKey(name: 'phone_number') String phoneNumber,
    String role,
    String? password,
    @JsonKey(name: 'terminal_pin') String? terminalPin,
  });
}

/// @nodoc
class __$$AssignBusinessRoleRequestImplCopyWithImpl<$Res>
    extends
        _$AssignBusinessRoleRequestCopyWithImpl<
          $Res,
          _$AssignBusinessRoleRequestImpl
        >
    implements _$$AssignBusinessRoleRequestImplCopyWith<$Res> {
  __$$AssignBusinessRoleRequestImplCopyWithImpl(
    _$AssignBusinessRoleRequestImpl _value,
    $Res Function(_$AssignBusinessRoleRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssignBusinessRoleRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? phoneNumber = null,
    Object? role = null,
    Object? password = freezed,
    Object? terminalPin = freezed,
  }) {
    return _then(
      _$AssignBusinessRoleRequestImpl(
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        password: freezed == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String?,
        terminalPin: freezed == terminalPin
            ? _value.terminalPin
            : terminalPin // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AssignBusinessRoleRequestImpl implements _AssignBusinessRoleRequest {
  const _$AssignBusinessRoleRequestImpl({
    @JsonKey(name: 'full_name') required this.fullName,
    required this.email,
    @JsonKey(name: 'phone_number') required this.phoneNumber,
    required this.role,
    this.password,
    @JsonKey(name: 'terminal_pin') this.terminalPin,
  });

  factory _$AssignBusinessRoleRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssignBusinessRoleRequestImplFromJson(json);

  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  final String email;
  @override
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @override
  final String role;
  @override
  final String? password;
  @override
  @JsonKey(name: 'terminal_pin')
  final String? terminalPin;

  @override
  String toString() {
    return 'AssignBusinessRoleRequest(fullName: $fullName, email: $email, phoneNumber: $phoneNumber, role: $role, password: $password, terminalPin: $terminalPin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssignBusinessRoleRequestImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.terminalPin, terminalPin) ||
                other.terminalPin == terminalPin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    fullName,
    email,
    phoneNumber,
    role,
    password,
    terminalPin,
  );

  /// Create a copy of AssignBusinessRoleRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssignBusinessRoleRequestImplCopyWith<_$AssignBusinessRoleRequestImpl>
  get copyWith =>
      __$$AssignBusinessRoleRequestImplCopyWithImpl<
        _$AssignBusinessRoleRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssignBusinessRoleRequestImplToJson(this);
  }
}

abstract class _AssignBusinessRoleRequest implements AssignBusinessRoleRequest {
  const factory _AssignBusinessRoleRequest({
    @JsonKey(name: 'full_name') required final String fullName,
    required final String email,
    @JsonKey(name: 'phone_number') required final String phoneNumber,
    required final String role,
    final String? password,
    @JsonKey(name: 'terminal_pin') final String? terminalPin,
  }) = _$AssignBusinessRoleRequestImpl;

  factory _AssignBusinessRoleRequest.fromJson(Map<String, dynamic> json) =
      _$AssignBusinessRoleRequestImpl.fromJson;

  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  String get email;
  @override
  @JsonKey(name: 'phone_number')
  String get phoneNumber;
  @override
  String get role;
  @override
  String? get password;
  @override
  @JsonKey(name: 'terminal_pin')
  String? get terminalPin;

  /// Create a copy of AssignBusinessRoleRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssignBusinessRoleRequestImplCopyWith<_$AssignBusinessRoleRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UserBusinessRole _$UserBusinessRoleFromJson(Map<String, dynamic> json) {
  return _UserBusinessRole.fromJson(json);
}

/// @nodoc
mixin _$UserBusinessRole {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_id')
  String get businessId => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'terminal_pin')
  String? get terminalPin => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserBusinessRole to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserBusinessRole
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserBusinessRoleCopyWith<UserBusinessRole> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserBusinessRoleCopyWith<$Res> {
  factory $UserBusinessRoleCopyWith(
    UserBusinessRole value,
    $Res Function(UserBusinessRole) then,
  ) = _$UserBusinessRoleCopyWithImpl<$Res, UserBusinessRole>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'business_id') String businessId,
    String role,
    @JsonKey(name: 'terminal_pin') String? terminalPin,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$UserBusinessRoleCopyWithImpl<$Res, $Val extends UserBusinessRole>
    implements $UserBusinessRoleCopyWith<$Res> {
  _$UserBusinessRoleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserBusinessRole
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? businessId = null,
    Object? role = null,
    Object? terminalPin = freezed,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            businessId: null == businessId
                ? _value.businessId
                : businessId // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            terminalPin: freezed == terminalPin
                ? _value.terminalPin
                : terminalPin // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
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
abstract class _$$UserBusinessRoleImplCopyWith<$Res>
    implements $UserBusinessRoleCopyWith<$Res> {
  factory _$$UserBusinessRoleImplCopyWith(
    _$UserBusinessRoleImpl value,
    $Res Function(_$UserBusinessRoleImpl) then,
  ) = __$$UserBusinessRoleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'business_id') String businessId,
    String role,
    @JsonKey(name: 'terminal_pin') String? terminalPin,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$UserBusinessRoleImplCopyWithImpl<$Res>
    extends _$UserBusinessRoleCopyWithImpl<$Res, _$UserBusinessRoleImpl>
    implements _$$UserBusinessRoleImplCopyWith<$Res> {
  __$$UserBusinessRoleImplCopyWithImpl(
    _$UserBusinessRoleImpl _value,
    $Res Function(_$UserBusinessRoleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserBusinessRole
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? businessId = null,
    Object? role = null,
    Object? terminalPin = freezed,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$UserBusinessRoleImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        businessId: null == businessId
            ? _value.businessId
            : businessId // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        terminalPin: freezed == terminalPin
            ? _value.terminalPin
            : terminalPin // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
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
class _$UserBusinessRoleImpl implements _UserBusinessRole {
  const _$UserBusinessRoleImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'business_id') required this.businessId,
    required this.role,
    @JsonKey(name: 'terminal_pin') this.terminalPin,
    @JsonKey(name: 'is_active') required this.isActive,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  });

  factory _$UserBusinessRoleImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserBusinessRoleImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'business_id')
  final String businessId;
  @override
  final String role;
  @override
  @JsonKey(name: 'terminal_pin')
  final String? terminalPin;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UserBusinessRole(id: $id, userId: $userId, businessId: $businessId, role: $role, terminalPin: $terminalPin, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserBusinessRoleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.terminalPin, terminalPin) ||
                other.terminalPin == terminalPin) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
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
    userId,
    businessId,
    role,
    terminalPin,
    isActive,
    createdAt,
    updatedAt,
  );

  /// Create a copy of UserBusinessRole
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserBusinessRoleImplCopyWith<_$UserBusinessRoleImpl> get copyWith =>
      __$$UserBusinessRoleImplCopyWithImpl<_$UserBusinessRoleImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserBusinessRoleImplToJson(this);
  }
}

abstract class _UserBusinessRole implements UserBusinessRole {
  const factory _UserBusinessRole({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'business_id') required final String businessId,
    required final String role,
    @JsonKey(name: 'terminal_pin') final String? terminalPin,
    @JsonKey(name: 'is_active') required final bool isActive,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$UserBusinessRoleImpl;

  factory _UserBusinessRole.fromJson(Map<String, dynamic> json) =
      _$UserBusinessRoleImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'business_id')
  String get businessId;
  @override
  String get role;
  @override
  @JsonKey(name: 'terminal_pin')
  String? get terminalPin;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of UserBusinessRole
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserBusinessRoleImplCopyWith<_$UserBusinessRoleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
