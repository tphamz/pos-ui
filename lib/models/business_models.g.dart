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

_$BusinessDetailResponseImpl _$$BusinessDetailResponseImplFromJson(
  Map<String, dynamic> json,
) => _$BusinessDetailResponseImpl(
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
  blueprint: json['blueprint'] == null
      ? null
      : Blueprint.fromJson(json['blueprint'] as Map<String, dynamic>),
  config: json['config'] == null
      ? null
      : BusinessConfig.fromJson(json['config'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$BusinessDetailResponseImplToJson(
  _$BusinessDetailResponseImpl instance,
) => <String, dynamic>{
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
  'blueprint': instance.blueprint,
  'config': instance.config,
};

_$BusinessConfigImpl _$$BusinessConfigImplFromJson(Map<String, dynamic> json) =>
    _$BusinessConfigImpl(
      id: json['id'] as String,
      businessId: json['business_id'] as String,
      brandSettings: json['brand_settings'] as Map<String, dynamic>?,
      activeModules: (json['active_modules'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      industryData: json['industry_data'] as Map<String, dynamic>?,
      hardwareMap: json['hardware_map'] as Map<String, dynamic>?,
      version: (json['version'] as num?)?.toInt() ?? 1,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$BusinessConfigImplToJson(
  _$BusinessConfigImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'business_id': instance.businessId,
  'brand_settings': instance.brandSettings,
  'active_modules': instance.activeModules,
  'industry_data': instance.industryData,
  'hardware_map': instance.hardwareMap,
  'version': instance.version,
  'updated_at': instance.updatedAt.toIso8601String(),
};

_$UpdateBusinessConfigRequestImpl _$$UpdateBusinessConfigRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateBusinessConfigRequestImpl(
  brandSettings: json['brand_settings'] as Map<String, dynamic>?,
  activeModules: (json['active_modules'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  industryData: json['industry_data'] as Map<String, dynamic>?,
  hardwareMap: json['hardware_map'] as Map<String, dynamic>?,
  version: (json['version'] as num?)?.toInt(),
);

Map<String, dynamic> _$$UpdateBusinessConfigRequestImplToJson(
  _$UpdateBusinessConfigRequestImpl instance,
) => <String, dynamic>{
  'brand_settings': instance.brandSettings,
  'active_modules': instance.activeModules,
  'industry_data': instance.industryData,
  'hardware_map': instance.hardwareMap,
  'version': instance.version,
};
