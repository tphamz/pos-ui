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
  otpToken: json['otpToken'] as String,
  otpCode: json['otpCode'] as String,
);

Map<String, dynamic> _$$VerifyOTPRequestImplToJson(
  _$VerifyOTPRequestImpl instance,
) => <String, dynamic>{
  'otpToken': instance.otpToken,
  'otpCode': instance.otpCode,
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

_$RequestOTPResponseImpl _$$RequestOTPResponseImplFromJson(
  Map<String, dynamic> json,
) => _$RequestOTPResponseImpl(
  otpToken: json['otpToken'] as String,
  expiresAt: DateTime.parse(json['expiresAt'] as String),
  message: json['message'] as String,
);

Map<String, dynamic> _$$RequestOTPResponseImplToJson(
  _$RequestOTPResponseImpl instance,
) => <String, dynamic>{
  'otpToken': instance.otpToken,
  'expiresAt': instance.expiresAt.toIso8601String(),
  'message': instance.message,
};

_$LoginResponseImpl _$$LoginResponseImplFromJson(Map<String, dynamic> json) =>
    _$LoginResponseImpl(
      token: json['token'] as String,
      csrfToken: json['csrfToken'] as String?,
      userId: json['userId'] as String,
      userType: json['userType'] as String,
      businessId: json['businessId'] as String?,
      storeCode: json['storeCode'] as String?,
      role: json['role'] as String?,
      businesses: (json['businesses'] as List<dynamic>?)
          ?.map((e) => BusinessRole.fromJson(e as Map<String, dynamic>))
          .toList(),
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$$LoginResponseImplToJson(_$LoginResponseImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'csrfToken': instance.csrfToken,
      'userId': instance.userId,
      'userType': instance.userType,
      'businessId': instance.businessId,
      'storeCode': instance.storeCode,
      'role': instance.role,
      'businesses': instance.businesses,
      'expiresAt': instance.expiresAt.toIso8601String(),
    };

_$BusinessRoleImpl _$$BusinessRoleImplFromJson(Map<String, dynamic> json) =>
    _$BusinessRoleImpl(
      businessId: json['businessId'] as String,
      businessName: json['businessName'] as String,
      storeCode: json['storeCode'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$$BusinessRoleImplToJson(_$BusinessRoleImpl instance) =>
    <String, dynamic>{
      'businessId': instance.businessId,
      'businessName': instance.businessName,
      'storeCode': instance.storeCode,
      'role': instance.role,
    };

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  id: json['id'] as String,
  fullName: json['full_name'] as String,
  phoneNumber: json['phone_number'] as String?,
  email: json['email'] as String?,
  isVerified: json['is_verified'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'is_verified': instance.isVerified,
      'created_at': instance.createdAt.toIso8601String(),
    };
