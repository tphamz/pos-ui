import 'package:dio/dio.dart';
import '../models/business_models.dart';
import '../services/api_client.dart';

class BusinessService {
  final ApiClient _apiClient;

  BusinessService(this._apiClient);

  // Get all businesses
  Future<List<Business>> getBusinesses() async {
    try {
      final response = await _apiClient.dio.get('/businesses');
      final List<dynamic> data = response.data;
      return data.map((json) => Business.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get business by ID (returns BusinessDetailResponse with blueprint and config)
  Future<BusinessDetailResponse> getBusiness(String id) async {
    try {
      final response = await _apiClient.dio.get('/businesses/$id');
      return BusinessDetailResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create business
  Future<Business> createBusiness(CreateBusinessRequest request) async {
    try {
      final response = await _apiClient.dio.post(
        '/businesses',
        data: request.toJson(),
      );
      return Business.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update business
  Future<Business> updateBusiness(
    String id,
    UpdateBusinessRequest request,
  ) async {
    try {
      final response = await _apiClient.dio.put(
        '/businesses/$id',
        data: request.toJson(),
      );
      return Business.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get business configuration
  Future<BusinessConfig> getBusinessConfig(String businessId) async {
    try {
      final response = await _apiClient.dio.get('/businesses/$businessId/config');
      return BusinessConfig.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update business configuration
  Future<BusinessConfig> updateBusinessConfig(
    String businessId,
    UpdateBusinessConfigRequest request,
  ) async {
    try {
      final response = await _apiClient.dio.put(
        '/businesses/$businessId/config',
        data: request.toJson(),
      );
      return BusinessConfig.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException error) {
    if (error.response != null) {
      final data = error.response!.data;
      if (data is Map<String, dynamic>) {
        return data['message'] as String? ?? 
               data['error'] as String? ?? 
               'An error occurred';
      }
    }
    return error.error?.toString() ?? 'An error occurred';
  }
}
