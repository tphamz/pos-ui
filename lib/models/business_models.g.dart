// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessImpl _$$BusinessImplFromJson(Map<String, dynamic> json) =>
    _$BusinessImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      storeCode: json['store_code'] as String?,
      taxNumber: json['tax_number'] as String?,
      currency: json['currency'] as String?,
      timezone: json['timezone'] as String?,
      status: json['status'] as String?,
      blueprintId: json['blueprint_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$BusinessImplToJson(_$BusinessImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'store_code': instance.storeCode,
      'tax_number': instance.taxNumber,
      'currency': instance.currency,
      'timezone': instance.timezone,
      'status': instance.status,
      'blueprint_id': instance.blueprintId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
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
