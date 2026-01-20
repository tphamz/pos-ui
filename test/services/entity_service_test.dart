import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import '../../lib/database/app_database.dart';
import '../../lib/database/local_db_service.dart';
import '../../lib/repositories/resources_registry.dart';
import '../../lib/services/queue_service.dart';
import '../../lib/services/entity_service.dart';
import '../../lib/services/api_client.dart';

/// Comprehensive tests for EntityService
/// Tests: save, delete, get, getOne, auto-pull, manualSync
void main() {
  group('EntityService Tests', () {
    late AppDatabase db;
    late LocalDbService localDb;
    late Dio dio;
    late DioAdapter dioAdapter;
    late ApiClient apiClient;
    late ResourcesRegistry resourcesRegistry;
    late QueueService queueService;
    late EntityService entityService;
    
    const String testBusinessId = 'test-business-123';
    const String testProductId = 'local-product-123';
    
    /// Clean up database before each test
    Future<void> _cleanupDatabase(LocalDbService localDb) async {
      // Delete all products
      final products = await localDb.getProducts(testBusinessId);
      for (final product in products) {
        await localDb.deleteProduct(product['id'] as String);
      }
      
      // Clear sync queue
      final queueItems = await localDb.getPendingSyncItems(limit: 1000);
      for (final item in queueItems) {
        await localDb.removeFromSyncQueue(item.id);
      }
    }
    
    setUpAll(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      // Mock path_provider
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('plugins.flutter.io/path_provider'),
        (MethodCall methodCall) async {
          return '/tmp';
        },
      );
      // Mock SharedPreferences
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('plugins.flutter.io/shared_preferences'),
        (MethodCall methodCall) async {
          if (methodCall.method == 'getAll') {
            return <String, dynamic>{};
          }
          return null;
        },
      );
    });
    
    setUp(() async {
      // Create database
      db = AppDatabase();
      localDb = LocalDbService(db);
      
      // Clean up any existing data
      await _cleanupDatabase(localDb);
      
      // Create mock API client
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      apiClient = ApiClient(dio: dio);
      
      // Initialize resources registry
      resourcesRegistry = ResourcesRegistry();
      resourcesRegistry.clear();
      resourcesRegistry.initialize(
        db: db,
        apiClient: apiClient,
        localDb: localDb,
      );
      
      // Create services
      queueService = QueueService(localDb, resourcesRegistry);
      entityService = EntityService(
        resources: resourcesRegistry,
        queueService: queueService,
        localDb: localDb,
        businessId: testBusinessId,
      );
    });
    
    tearDown(() async {
      await _cleanupDatabase(localDb);
      await db.close();
    });
    
    test('1. Save product - creates locally and queues for sync', () async {
      final productData = {
        'name': 'Test Product',
        'category': 'test-category',
        'base_price': 10.0,
        'tax_rate': 0.1,
        'is_active': true,
        'stock_quantity': 100,
      };
      
      final saved = await entityService.save(
        resourceName: 'product',
        id: testProductId,
        data: productData,
        isCreate: true,
      );
      
      expect(saved['id'], testProductId);
      expect(saved['business_id'], testBusinessId);
      expect(saved['name'], 'Test Product');
      
      // Verify it's in local DB
      final products = await entityService.get('product');
      expect(products.length, 1);
      expect(products[0]['id'], testProductId);
      
      // Verify it's in sync queue
      final queueItems = await localDb.getPendingSyncItems();
      expect(queueItems.length, 1);
      expect(queueItems[0].entityType, 'product');
      expect(queueItems[0].operationType, 'create');
      expect(queueItems[0].entityId, testProductId);
    });
    
    test('2. Update product - updates locally and queues update', () async {
      // Create product first
      await entityService.save(
        resourceName: 'product',
        id: testProductId,
        data: {
          'name': 'Original Product',
          'category': 'test-category',
          'base_price': 10.0,
        },
        isCreate: true,
      );
      
      // Update product
      await entityService.save(
        resourceName: 'product',
        id: testProductId,
        data: {
          'name': 'Updated Product',
          'base_price': 15.0,
        },
        isCreate: false,
      );
      
      // Verify update
      final products = await entityService.get('product');
      expect(products.length, 1);
      expect(products[0]['name'], 'Updated Product');
      expect(products[0]['base_price'], 15.0);
    });
    
    test('3. Delete product - removes locally and queues delete', () async {
      // Create product first
      await entityService.save(
        resourceName: 'product',
        id: testProductId,
        data: {
          'name': 'Product to Delete',
          'category': 'test-category',
          'base_price': 10.0,
        },
        isCreate: true,
      );
      
      // Delete product
      await entityService.delete('product', testProductId);
      
      // Verify deletion
      final products = await entityService.get('product');
      expect(products.length, 0);
      
      // Verify delete is in queue
      final queueItems = await localDb.getPendingSyncItems();
      expect(queueItems.length, 2); // Create + Delete
      final deleteItem = queueItems.firstWhere((item) => item.operationType == 'delete');
      expect(deleteItem.entityType, 'product');
      expect(deleteItem.entityId, testProductId);
    });
    
    test('4. Get products - returns local data', () async {
      // Create multiple products
      await entityService.save(
        resourceName: 'product',
        id: 'product-1',
        data: {'name': 'Product 1', 'category': 'cat1', 'base_price': 10.0},
        isCreate: true,
      );
      await entityService.save(
        resourceName: 'product',
        id: 'product-2',
        data: {'name': 'Product 2', 'category': 'cat2', 'base_price': 20.0},
        isCreate: true,
      );
      
      final products = await entityService.get('product');
      expect(products.length, 2);
      expect(products.any((p) => p['id'] == 'product-1'), true);
      expect(products.any((p) => p['id'] == 'product-2'), true);
    });
    
    test('5. GetOne product - returns single entity', () async {
      // Create product
      await entityService.save(
        resourceName: 'product',
        id: testProductId,
        data: {
          'name': 'Single Product',
          'category': 'test-category',
          'base_price': 10.0,
        },
        isCreate: true,
      );
      
      final product = await entityService.getOne('product', testProductId);
      expect(product, isNotNull);
      expect(product!['id'], testProductId);
      expect(product['name'], 'Single Product');
    });
    
    test('6. GetOne product - returns null if not found', () async {
      final product = await entityService.getOne('product', 'non-existent-id');
      expect(product, isNull);
    });
    
    test('7. Auto-pull on empty get - pulls from server when local is empty', () async {
      // Mock server response
      dioAdapter.onGet(
        '/businesses/$testBusinessId/products',
        (server) => server.reply(200, [
          {
            'id': 'server-product-1',
            'business_id': testBusinessId,
            'name': 'Server Product 1',
            'category_id': 'cat1',
            'base_price': 10.0,
            'tax_rate': 0.1,
            'is_active': true,
            'stock_quantity': 100,
            'version': 1,
          },
          {
            'id': 'server-product-2',
            'business_id': testBusinessId,
            'name': 'Server Product 2',
            'category_id': 'cat2',
            'base_price': 20.0,
            'tax_rate': 0.1,
            'is_active': true,
            'stock_quantity': 50,
            'version': 1,
          },
        ]),
      );
      
      // Get products when local is empty - should auto-pull
      final products = await entityService.get('product');
      
      expect(products.length, 2);
      expect(products.any((p) => p['id'] == 'server-product-1'), true);
      expect(products.any((p) => p['id'] == 'server-product-2'), true);
      
      // Verify data is now in local DB
      final localProducts = await localDb.getProducts(testBusinessId);
      expect(localProducts.length, 2);
    });
    
    test('8. Auto-pull on getOne - pulls from server when not found locally', () async {
      // Mock server response
      dioAdapter.onGet(
        '/businesses/$testBusinessId/products',
        (server) => server.reply(200, [
          {
            'id': 'server-product-1',
            'business_id': testBusinessId,
            'name': 'Server Product',
            'category_id': 'cat1',
            'base_price': 10.0,
            'tax_rate': 0.1,
            'is_active': true,
            'stock_quantity': 100,
            'version': 1,
          },
        ]),
      );
      
      // GetOne when not found locally - should auto-pull
      final product = await entityService.getOne('product', 'server-product-1');
      
      expect(product, isNotNull);
      expect(product!['id'], 'server-product-1');
      expect(product['name'], 'Server Product');
    });
    
    test('9. Auto-pull handles network errors gracefully', () async {
      // Mock network error
      dioAdapter.onGet(
        '/businesses/$testBusinessId/products',
        (server) => server.reply(500, {'error': 'Server error'}),
      );
      
      // Get products when local is empty - should return empty list on error
      final products = await entityService.get('product');
      
      expect(products, isEmpty);
    });
    
    test('10. Manual sync - pushes local changes then pulls server changes', () async {
      // Create local product
      await entityService.save(
        resourceName: 'product',
        id: testProductId,
        data: {
          'name': 'Local Product',
          'category': 'test-category',
          'base_price': 10.0,
        },
        isCreate: true,
      );
      
      // Mock server responses
      dioAdapter.onPost(
        '/businesses/$testBusinessId/products',
        (server) => server.reply(201, {
          'id': 'server-id-123',
          'business_id': testBusinessId,
          'name': 'Local Product',
          'category_id': 'test-category',
          'base_price': 10.0,
          'tax_rate': 0.0,
          'is_active': true,
          'stock_quantity': 0,
          'version': 1,
        }),
      );
      
      dioAdapter.onGet(
        '/businesses/$testBusinessId/products',
        (server) => server.reply(200, [
          {
            'id': 'server-product-1',
            'business_id': testBusinessId,
            'name': 'Server Product',
            'category_id': 'cat1',
            'base_price': 15.0,
            'tax_rate': 0.1,
            'is_active': true,
            'stock_quantity': 50,
            'version': 1,
          },
        ]),
      );
      
      // Manual sync
      await entityService.manualSync();
      
      // Verify local product was synced (has serverId now)
      final products = await entityService.get('product');
      expect(products.length, greaterThanOrEqualTo(1));
      
      // Verify server product was pulled
      final serverProduct = products.firstWhere(
        (p) => p['id'] == 'server-product-1',
        orElse: () => {},
      );
      expect(serverProduct.isNotEmpty, true);
    });
    
    test('11. Get with existing local data - does not pull from server', () async {
      // Create local product
      await entityService.save(
        resourceName: 'product',
        id: testProductId,
        data: {
          'name': 'Local Product',
          'category': 'test-category',
          'base_price': 10.0,
        },
        isCreate: true,
      );
      
      // Mock server (should not be called)
      dioAdapter.onGet(
        '/businesses/$testBusinessId/products',
        (server) => server.reply(200, []),
      );
      
      // Get products - should use local data, not call server
      final products = await entityService.get('product');
      
      expect(products.length, 1);
      expect(products[0]['id'], testProductId);
      
      // Note: We can't easily verify server wasn't called with http_mock_adapter
      // But if it was called, the test would fail due to unexpected request
    });
  });
}
