// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestOTPRequestImpl _$$RequestOTPRequestImplFromJson(
  Map<String, dynamic> json,
) => _$RequestOTPRequestImpl(
  contact: json['contact'] as String,
  storeCode: json['storeCode'] as String?,
);

Map<String, dynamic> _$$RequestOTPRequestImplToJson(
  _$RequestOTPRequestImpl instance,
) => <String, dynamic>{
  'contact': instance.contact,
  'storeCode': instance.storeCode,
};

_$VerifyOTPRequestImpl _$$VerifyOTPRequestImplFromJson(
  Map<String, dynamic> json,
) => _$VerifyOTPRequestImpl(
  otpToken: json['otp_token'] as String,
  otpCode: json['otp_code'] as String,
);

Map<String, dynamic> _$$VerifyOTPRequestImplToJson(
  _$VerifyOTPRequestImpl instance,
) => <String, dynamic>{
  'otp_token': instance.otpToken,
  'otp_code': instance.otpCode,
};

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      contact: json['contact'] as String,
      password: json['password'] as String,
      storeCode: json['storeCode'] as String?,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{
      'contact': instance.contact,
      'password': instance.password,
      'storeCode': instance.storeCode,
    };

_$LoginTerminalRequestImpl _$$LoginTerminalRequestImplFromJson(
  Map<String, dynamic> json,
) => _$LoginTerminalRequestImpl(
  phone: json['phone'] as String,
  storeCode: json['storeCode'] as String,
  pin: json['pin'] as String,
);

Map<String, dynamic> _$$LoginTerminalRequestImplToJson(
  _$LoginTerminalRequestImpl instance,
) => <String, dynamic>{
  'phone': instance.phone,
  'storeCode': instance.storeCode,
  'pin': instance.pin,
};

_$CreateUserRequestImpl _$$CreateUserRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateUserRequestImpl(
  fullName: json['full_name'] as String,
  phoneNumber: json['phone_number'] as String?,
  email: json['email'] as String?,
  password: json['password'] as String?,
);

Map<String, dynamic> _$$CreateUserRequestImplToJson(
  _$CreateUserRequestImpl instance,
) => <String, dynamic>{
  'full_name': instance.fullName,
  'phone_number': instance.phoneNumber,
  'email': instance.email,
  'password': instance.password,
};

_$SignUpRequestImpl _$$SignUpRequestImplFromJson(Map<String, dynamic> json) =>
    _$SignUpRequestImpl(
      fullName: json['full_name'] as String,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      businessName: json['business_name'] as String,
      blueprintId: json['blueprint_id'] as String,
    );

Map<String, dynamic> _$$SignUpRequestImplToJson(_$SignUpRequestImpl instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'password': instance.password,
      'business_name': instance.businessName,
      'blueprint_id': instance.blueprintId,
    };

_$RequestOTPResponseImpl _$$RequestOTPResponseImplFromJson(
  Map<String, dynamic> json,
) => _$RequestOTPResponseImpl(
  otpToken: json['otp_token'] as String,
  expiresAt: DateTime.parse(json['expires_at'] as String),
  message: json['message'] as String,
);

Map<String, dynamic> _$$RequestOTPResponseImplToJson(
  _$RequestOTPResponseImpl instance,
) => <String, dynamic>{
  'otp_token': instance.otpToken,
  'expires_at': instance.expiresAt.toIso8601String(),
  'message': instance.message,
};

_$LoginResponseImpl _$$LoginResponseImplFromJson(Map<String, dynamic> json) =>
    _$LoginResponseImpl(
      token: json['token'] as String,
      csrfToken: json['csrf_token'] as String?,
      userId: json['user_id'] as String,
      userType: json['user_type'] as String,
      businessId: json['business_id'] as String?,
      storeCode: json['store_code'] as String?,
      role: json['role'] as String?,
      businesses: (json['businesses'] as List<dynamic>?)
          ?.map((e) => BusinessRole.fromJson(e as Map<String, dynamic>))
          .toList(),
      expiresAt: DateTime.parse(json['expires_at'] as String),
    );

Map<String, dynamic> _$$LoginResponseImplToJson(_$LoginResponseImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'csrf_token': instance.csrfToken,
      'user_id': instance.userId,
      'user_type': instance.userType,
      'business_id': instance.businessId,
      'store_code': instance.storeCode,
      'role': instance.role,
      'businesses': instance.businesses,
      'expires_at': instance.expiresAt.toIso8601String(),
    };

_$BusinessRoleImpl _$$BusinessRoleImplFromJson(Map<String, dynamic> json) =>
    _$BusinessRoleImpl(
      businessId: json['business_id'] as String,
      storeCode: json['store_code'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$$BusinessRoleImplToJson(_$BusinessRoleImpl instance) =>
    <String, dynamic>{
      'business_id': instance.businessId,
      'store_code': instance.storeCode,
      'role': instance.role,
    };

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  id: json['id'] as String,
  fullName: json['full_name'] as String,
  phoneNumber: json['phone_number'] as String?,
  email: json['email'] as String?,
  isVerified: json['is_verified'] as bool,
  version: (json['version'] as num?)?.toInt() ?? 1,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'is_verified': instance.isVerified,
      'version': instance.version,
      'created_at': instance.createdAt.toIso8601String(),
    };

_$SignUpResponseImpl _$$SignUpResponseImplFromJson(Map<String, dynamic> json) =>
    _$SignUpResponseImpl(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      business: Business.fromJson(json['business'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SignUpResponseImplToJson(
  _$SignUpResponseImpl instance,
) => <String, dynamic>{'user': instance.user, 'business': instance.business};

_$AssignBusinessRoleRequestImpl _$$AssignBusinessRoleRequestImplFromJson(
  Map<String, dynamic> json,
) => _$AssignBusinessRoleRequestImpl(
  fullName: json['full_name'] as String,
  email: json['email'] as String,
  phoneNumber: json['phone_number'] as String,
  role: json['role'] as String,
  password: json['password'] as String?,
  terminalPin: json['terminal_pin'] as String?,
);

Map<String, dynamic> _$$AssignBusinessRoleRequestImplToJson(
  _$AssignBusinessRoleRequestImpl instance,
) => <String, dynamic>{
  'full_name': instance.fullName,
  'email': instance.email,
  'phone_number': instance.phoneNumber,
  'role': instance.role,
  'password': instance.password,
  'terminal_pin': instance.terminalPin,
};

_$UserBusinessRoleImpl _$$UserBusinessRoleImplFromJson(
  Map<String, dynamic> json,
) => _$UserBusinessRoleImpl(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  businessId: json['business_id'] as String,
  role: json['role'] as String,
  terminalPin: json['terminal_pin'] as String?,
  isActive: json['is_active'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$UserBusinessRoleImplToJson(
  _$UserBusinessRoleImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'business_id': instance.businessId,
  'role': instance.role,
  'terminal_pin': instance.terminalPin,
  'is_active': instance.isActive,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
