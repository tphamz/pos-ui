// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessImpl _$$BusinessImplFromJson(Map<String, dynamic> json) =>
    _$BusinessImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      storeCode: json['storeCode'] as String?,
      taxNumber: json['taxNumber'] as String?,
      currency: json['currency'] as String?,
      timezone: json['timezone'] as String?,
      status: json['status'] as String?,
      blueprintId: json['blueprintId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$BusinessImplToJson(_$BusinessImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'storeCode': instance.storeCode,
      'taxNumber': instance.taxNumber,
      'currency': instance.currency,
      'timezone': instance.timezone,
      'status': instance.status,
      'blueprintId': instance.blueprintId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$CreateBusinessRequestImpl _$$CreateBusinessRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateBusinessRequestImpl(
  blueprintId: json['blueprintId'] as String?,
  name: json['name'] as String,
  storeCode: json['storeCode'] as String?,
  taxNumber: json['taxNumber'] as String?,
  currency: json['currency'] as String?,
  timezone: json['timezone'] as String?,
);

Map<String, dynamic> _$$CreateBusinessRequestImplToJson(
  _$CreateBusinessRequestImpl instance,
) => <String, dynamic>{
  'blueprintId': instance.blueprintId,
  'name': instance.name,
  'storeCode': instance.storeCode,
  'taxNumber': instance.taxNumber,
  'currency': instance.currency,
  'timezone': instance.timezone,
};

_$UpdateBusinessRequestImpl _$$UpdateBusinessRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateBusinessRequestImpl(
  name: json['name'] as String?,
  storeCode: json['storeCode'] as String?,
  taxNumber: json['taxNumber'] as String?,
  currency: json['currency'] as String?,
  timezone: json['timezone'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$$UpdateBusinessRequestImplToJson(
  _$UpdateBusinessRequestImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'storeCode': instance.storeCode,
  'taxNumber': instance.taxNumber,
  'currency': instance.currency,
  'timezone': instance.timezone,
  'status': instance.status,
};
