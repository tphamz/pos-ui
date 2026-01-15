import 'package:freezed_annotation/freezed_annotation.dart';

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
