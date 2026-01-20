import 'package:dio/dio.dart';
import '../models/blueprint_models.dart';
import '../services/api_client.dart';

class BlueprintService {
  final ApiClient _apiClient;

  BlueprintService(this._apiClient);

  /// Get a list of available blueprints (public endpoint)
  /// Used during signup to show available business types
  Future<List<BlueprintListItem>> getBlueprints({
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        '/blueprints',
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
      );

      // Check if response is successful
      if (response.statusCode != null && response.statusCode! >= 400) {
        throw _handleError(DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        ));
      }

      // Validate response data is a List
      if (response.data is! List) {
        throw 'Invalid response format from server';
      }

      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => BlueprintListItem.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      // Handle non-DioException errors (like type cast errors)
      if (e is TypeError) {
        throw 'Invalid response format from server. Please try again.';
      }
      rethrow;
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

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return 'Connection timeout. Please check your internet connection.';
    }

    if (error.type == DioExceptionType.connectionError) {
      return 'Failed to connect to server. Please check your internet connection.';
    }

    return error.message ?? 'An unknown error occurred';
  }
}
