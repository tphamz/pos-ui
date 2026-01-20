import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';
import 'blueprint_models.dart';

part 'business_models.freezed.dart';
part 'business_models.g.dart';

@freezed
class Business with _$Business {
  const factory Business({
    required String id,
    required String name,
    @JsonKey(name: 'store_code') String? storeCode,
    @JsonKey(name: 'tax_number') String? taxNumber,
    String? currency,
    String? timezone,
    String? status,
    @JsonKey(name: 'blueprint_id') String? blueprintId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Business;

  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);
}

@freezed
class CreateBusinessRequest with _$CreateBusinessRequest {
  const factory CreateBusinessRequest({
    String? blueprintId,
    required String name,
    String? storeCode,
    String? taxNumber,
    String? currency,
    String? timezone,
  }) = _CreateBusinessRequest;

  factory CreateBusinessRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateBusinessRequestFromJson(json);
}

@freezed
class UpdateBusinessRequest with _$UpdateBusinessRequest {
  const factory UpdateBusinessRequest({
    String? name,
    String? storeCode,
    String? taxNumber,
    String? currency,
    String? timezone,
    String? status,
  }) = _UpdateBusinessRequest;

  factory UpdateBusinessRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateBusinessRequestFromJson(json);
}

/// BusinessDetailResponse represents a business with its blueprint and config
/// This is the response from GET /businesses/:id
@freezed
class BusinessDetailResponse with _$BusinessDetailResponse {
  const factory BusinessDetailResponse({
    // Business fields (flattened from core.Business)
    required String id,
    required String name,
    @JsonKey(name: 'store_code') String? storeCode,
    @JsonKey(name: 'tax_number') String? taxNumber,
    String? currency,
    String? timezone,
    String? status,
    @JsonKey(name: 'blueprint_id') String? blueprintId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    // Additional fields from BusinessDetailResponse
    Blueprint? blueprint,
    BusinessConfig? config,
  }) = _BusinessDetailResponse;

  factory BusinessDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$BusinessDetailResponseFromJson(json);
}

/// BusinessConfig represents business-specific configuration
@freezed
class BusinessConfig with _$BusinessConfig {
  const factory BusinessConfig({
    required String id,
    @JsonKey(name: 'business_id') required String businessId,
    @JsonKey(name: 'brand_settings') Map<String, dynamic>? brandSettings,
    @JsonKey(name: 'active_modules') List<String>? activeModules,
    @JsonKey(name: 'industry_data') Map<String, dynamic>? industryData,
    @JsonKey(name: 'hardware_map') Map<String, dynamic>? hardwareMap,
    @Default(1) int version, // Optimistic locking version
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _BusinessConfig;

  factory BusinessConfig.fromJson(Map<String, dynamic> json) =>
      _$BusinessConfigFromJson(json);
}

/// UpdateBusinessConfigRequest represents a request to update business configuration
@freezed
class UpdateBusinessConfigRequest with _$UpdateBusinessConfigRequest {
  const factory UpdateBusinessConfigRequest({
    @JsonKey(name: 'brand_settings') Map<String, dynamic>? brandSettings,
    @JsonKey(name: 'active_modules') List<String>? activeModules,
    @JsonKey(name: 'industry_data') Map<String, dynamic>? industryData,
    @JsonKey(name: 'hardware_map') Map<String, dynamic>? hardwareMap,
    int? version, // Optional version for optimistic locking
  }) = _UpdateBusinessConfigRequest;

  factory UpdateBusinessConfigRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateBusinessConfigRequestFromJson(json);
}
