import 'package:freezed_annotation/freezed_annotation.dart';

part 'blueprint_models.freezed.dart';
part 'blueprint_models.g.dart';

/// BlueprintListItem represents a blueprint in a list response (limited fields)
/// Used for listing available blueprints (e.g., during signup)
@freezed
class BlueprintListItem with _$BlueprintListItem {
  const factory BlueprintListItem({
    required String id,
    required String name,
    @JsonKey(name: 'bp_code') required String bpCode,
  }) = _BlueprintListItem;

  factory BlueprintListItem.fromJson(Map<String, dynamic> json) =>
      _$BlueprintListItemFromJson(json);
}

/// Blueprint represents a full blueprint with all JSONB configuration fields
/// JSONB fields from the backend are automatically parsed as Map<String, dynamic>
@freezed
class Blueprint with _$Blueprint {
  const factory Blueprint({
    required String id,
    required String name,
    @JsonKey(name: 'bp_code') required String bpCode,
    required int version,
    @JsonKey(name: 'ui_schema') Map<String, dynamic>? uiSchema,
    @JsonKey(name: 'module_definitions') Map<String, dynamic>? moduleDefinitions,
    @JsonKey(name: 'logic_rules') Map<String, dynamic>? logicRules,
    @JsonKey(name: 'label_mappings') Map<String, dynamic>? labelMappings,
    Map<String, dynamic>? permissions,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Blueprint;

  factory Blueprint.fromJson(Map<String, dynamic> json) =>
      _$BlueprintFromJson(json);
}
