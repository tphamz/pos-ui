import '../models/product_models.dart';
import '../services/entity_service.dart';

/// Typed convenience service for Product operations
/// Delegates to EntityService internally for actual operations
/// Provides type-safe Product and Category models
class ProductService {
  final EntityService _entityService;
  final String _businessId;

  ProductService(EntityService entityService, String businessId)
      : _entityService = entityService,
        _businessId = businessId;

  // Get products for a business (typed)
  Future<List<Product>> getProducts() async {
    final data = await _entityService.get('product');
    return data.map((json) => Product.fromJson(json)).toList();
  }

  // Get product by ID (typed)
  Future<Product?> getProduct(String productId) async {
    final data = await _entityService.getOne('product', productId);
    if (data == null) return null;
    return Product.fromJson(data);
  }

  // Create product (typed)
  Future<Product> createProduct(CreateProductRequest request) async {
    final productId = DateTime.now().millisecondsSinceEpoch.toString();
    final result = await _entityService.save(
      resourceName: 'product',
      id: productId,
      data: request.toJson(),
      isCreate: true,
    );
    return Product.fromJson(result);
  }

  // Update product (typed)
  Future<Product> updateProduct(String productId, UpdateProductRequest request) async {
    final result = await _entityService.save(
      resourceName: 'product',
      id: productId,
      data: request.toJson(),
      isCreate: false,
    );
    return Product.fromJson(result);
  }

  // Delete product (typed)
  Future<void> deleteProduct(String productId) async {
    await _entityService.delete('product', productId);
  }

  // Get categories (direct API call - categories not in repository pattern yet)
  Future<List<Category>> getCategories() async {
    // Categories are not part of the repository pattern yet
    // For now, use direct API call via EntityService
    // TODO: Create CategoryRemoteRepository if categories become a full entity
    final apiClient = _entityService.getApiClient('product');
    if (apiClient == null) {
      throw Exception('Product resource not found');
    }
    
    try {
      final response = await apiClient.dio.get(
        '/businesses/$_businessId/products/categories',
      );
      final List<dynamic> data = response.data;
      return data.map((json) => Category.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      rethrow;
    }
  }

  // Create category (direct API call - categories not in repository pattern yet)
  Future<Category> createCategory(CreateCategoryRequest request) async {
    // Categories are not part of the repository pattern yet
    // For now, use direct API call
    // TODO: Create CategoryRemoteRepository if categories become a full entity
    final apiClient = _entityService.getApiClient('product');
    if (apiClient == null) {
      throw Exception('Product resource not found');
    }
    
    try {
      final response = await apiClient.dio.post(
        '/businesses/$_businessId/products/categories',
        data: request.toJson(),
      );
      return Category.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
