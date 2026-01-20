// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blueprint_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BlueprintListItemImpl _$$BlueprintListItemImplFromJson(
  Map<String, dynamic> json,
) => _$BlueprintListItemImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  bpCode: json['bp_code'] as String,
);

Map<String, dynamic> _$$BlueprintListItemImplToJson(
  _$BlueprintListItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'bp_code': instance.bpCode,
};

_$BlueprintImpl _$$BlueprintImplFromJson(Map<String, dynamic> json) =>
    _$BlueprintImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      bpCode: json['bp_code'] as String,
      version: (json['version'] as num).toInt(),
      uiSchema: json['ui_schema'] as Map<String, dynamic>?,
      moduleDefinitions: json['module_definitions'] as Map<String, dynamic>?,
      logicRules: json['logic_rules'] as Map<String, dynamic>?,
      labelMappings: json['label_mappings'] as Map<String, dynamic>?,
      permissions: json['permissions'] as Map<String, dynamic>?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$BlueprintImplToJson(_$BlueprintImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bp_code': instance.bpCode,
      'version': instance.version,
      'ui_schema': instance.uiSchema,
      'module_definitions': instance.moduleDefinitions,
      'logic_rules': instance.logicRules,
      'label_mappings': instance.labelMappings,
      'permissions': instance.permissions,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
