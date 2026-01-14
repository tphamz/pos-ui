import 'package:dio/dio.dart';
import '../models/product_models.dart';
import '../services/api_client.dart';

class ProductService {
  final ApiClient _apiClient;

  ProductService(this._apiClient);

  // Get products for a business
  Future<List<Product>> getProducts(String businessId) async {
    try {
      final response = await _apiClient.dio.get(
        '/businesses/$businessId/products',
      );
      final List<dynamic> data = response.data;
      return data.map((json) => Product.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get product by ID
  Future<Product> getProduct(String businessId, String productId) async {
    try {
      final response = await _apiClient.dio.get(
        '/businesses/$businessId/products/$productId',
      );
      return Product.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create product
  Future<Product> createProduct(
    String businessId,
    CreateProductRequest request,
  ) async {
    try {
      final response = await _apiClient.dio.post(
        '/businesses/$businessId/products',
        data: request.toJson(),
      );
      return Product.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update product
  Future<Product> updateProduct(
    String businessId,
    String productId,
    UpdateProductRequest request,
  ) async {
    try {
      final response = await _apiClient.dio.put(
        '/businesses/$businessId/products/$productId',
        data: request.toJson(),
      );
      return Product.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete product
  Future<void> deleteProduct(String businessId, String productId) async {
    try {
      await _apiClient.dio.delete(
        '/businesses/$businessId/products/$productId',
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get categories
  Future<List<Category>> getCategories(String businessId) async {
    try {
      final response = await _apiClient.dio.get(
        '/businesses/$businessId/products/categories',
      );
      final List<dynamic> data = response.data;
      return data.map((json) => Category.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create category
  Future<Category> createCategory(
    String businessId,
    CreateCategoryRequest request,
  ) async {
    try {
      final response = await _apiClient.dio.post(
        '/businesses/$businessId/products/categories',
        data: request.toJson(),
      );
      return Category.fromJson(response.data);
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
