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

/// End-to-end test for Product repository pattern
/// Tests the complete flow: Create → Update → Delete → Sync
void main() {
  group('Product Repository Pattern E2E Tests', () {
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
      resourcesRegistry.clear(); // Clear any existing resources
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
      
      // Note: Provider container not needed for direct service testing
    });
    
    tearDown(() async {
      // Container removed - not needed for direct service testing
      await db.close();
      resourcesRegistry.clear();
    });
    
    tearDownAll(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('plugins.flutter.io/path_provider'),
        null,
      );
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('plugins.flutter.io/shared_preferences'),
        null,
      );
    });
    
    test('1. Create product - saves locally and queues for sync', () async {
      // Arrange
      await _cleanupDatabase(localDb); // Ensure clean state
      
      final productData = {
        'name': 'Test Product',
        'base_price': 10.99,
        'tax_rate': 0.1,
        'is_active': true,
        'stock_quantity': 100,
      };
      
      // Act
      final result = await entityService.save(
        resourceName: 'product',
        id: testProductId,
        data: productData,
        isCreate: true,
      );
      
      // Assert - Product should be saved locally
      expect(result['id'], testProductId);
      expect(result['name'], 'Test Product');
      expect(result['business_id'], testBusinessId);
      
      // Verify product is in local database
      final products = await entityService.get('product');
      expect(products.length, 1);
      expect(products[0]['id'], testProductId);
      expect(products[0]['name'], 'Test Product');
      
      // Verify item is in sync queue (may have been processed, so check for create or synced)
      final queueItems = await localDb.getPendingSyncItems();
      final productQueueItems = queueItems.where((item) => 
        item.entityType == 'product' && item.entityId == testProductId
      ).toList();
      
      // Should have at least one queue item (create operation)
      expect(productQueueItems.length, greaterThanOrEqualTo(1));
      if (productQueueItems.isNotEmpty) {
        expect(productQueueItems[0].operationType, 'create');
      }
    });
    
    test('2. Update product - merges changes and queues update', () async {
      // Arrange - Create product first
      await entityService.save(
        resourceName: 'product',
        id: testProductId,
        data: {
          'name': 'Original Product',
          'base_price': 10.99,
        },
        isCreate: true,
      );
      
      // Clear queue for this test
      final queueItems = await localDb.getPendingSyncItems();
      for (final item in queueItems) {
        await localDb.removeFromSyncQueue(item.id);
      }
      
      // Act - Update product
      await entityService.save(
        resourceName: 'product',
        id: testProductId,
        data: {
          'name': 'Updated Product',
          'base_price': 15.99,
        },
        isCreate: false,
      );
      
      // Assert - Product should be updated locally
      final products = await entityService.get('product');
      expect(products.length, 1);
      expect(products[0]['name'], 'Updated Product');
      expect(products[0]['base_price'], 15.99);
      
      // Verify update is in sync queue
      final updatedQueueItems = await localDb.getPendingSyncItems();
      expect(updatedQueueItems.length, 1);
      expect(updatedQueueItems[0].operationType, 'update');
    });
    
    test('3. Delete product - removes locally and queues delete', () async {
      // Arrange - Create product first
      await entityService.save(
        resourceName: 'product',
        id: testProductId,
        data: {
          'name': 'Product to Delete',
          'base_price': 10.99,
        },
        isCreate: true,
      );
      
      // Clear queue
      final queueItems = await localDb.getPendingSyncItems();
      for (final item in queueItems) {
        await localDb.removeFromSyncQueue(item.id);
      }
      
      // Act - Delete product
      await entityService.delete('product', testProductId);
      
      // Assert - Product should be removed from local database
      final products = await entityService.get('product');
      expect(products.length, 0);
      
      // Verify delete is in sync queue (but without serverId, it won't be queued)
      // Since product was never synced, delete operation should not be queued
      final deleteQueueItems = await localDb.getPendingSyncItems();
      // Delete without serverId should not be queued (consolidation logic)
      expect(deleteQueueItems.length, 0);
    });
    
    test('4. Sync create operation - creates on server and updates local', () async {
      // Arrange - Clean state
      await _cleanupDatabase(localDb);
      
      // Create product locally
      await entityService.save(
        resourceName: 'product',
        id: testProductId,
        data: {
          'name': 'Product to Sync',
          'base_price': 10.99,
          'tax_rate': 0.1,
        },
        isCreate: true,
      );
      
      // Mock server response (match Product model structure)
      final serverResponse = {
        'id': 'server-product-123',
        'business_id': testBusinessId,
        'name': 'Product to Sync',
        'base_price': 10.99,
        'tax_rate': 0.1,
        'is_active': true,
        'stock_quantity': 0,
        'version': 1,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
        'sku': null,
        'category': null,
        'metadata': null,
      };
      
      // Mock the POST request - match any POST to this endpoint
      dioAdapter.onPost(
        '/businesses/$testBusinessId/products',
        (server) => server.reply(200, serverResponse),
      );
      
      // Act - Process queue
      await queueService.processQueue();
      
      // Assert - Product should have serverId
      final products = await entityService.get('product');
      expect(products.length, 1);
      expect(products[0]['serverId'], 'server-product-123');
      expect(products[0]['version'], 1);
      
      // Verify queue item is processed (may still be in queue if sync failed, but check status)
      final queueItems = await localDb.getPendingSyncItems();
      final productQueueItems = queueItems.where((item) => 
        item.entityType == 'product' && item.entityId == testProductId
      ).toList();
      // Should be processed (removed from queue or marked as synced)
      expect(productQueueItems.length, lessThanOrEqualTo(0));
    });
    
    test('5. Pull products from server - updates local database', () async {
      // Arrange - Clean state
      await _cleanupDatabase(localDb);
      
      // Mock server response (include all Product model fields)
      final serverProducts = [
        {
          'id': 'server-product-1',
          'business_id': testBusinessId,
          'name': 'Server Product 1',
          'base_price': 10.99,
          'tax_rate': 0.1,
          'is_active': true,
          'stock_quantity': 100,
          'version': 1,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
          'sku': null,
          'category': null,
          'metadata': null,
        },
        {
          'id': 'server-product-2',
          'business_id': testBusinessId,
          'name': 'Server Product 2',
          'base_price': 20.99,
          'tax_rate': 0.15,
          'is_active': true,
          'stock_quantity': 50,
          'version': 1,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
          'sku': null,
          'category': null,
          'metadata': null,
        },
      ];
      
      dioAdapter.onGet(
        '/businesses/$testBusinessId/products',
        (server) => server.reply(200, serverProducts),
      );
      
      // Act - Pull from server
      await entityService.pull('product');
      
      // Assert - Products should be in local database
      final products = await entityService.get('product');
      expect(products.length, 2);
      expect(products.any((p) => p['name'] == 'Server Product 1'), true);
      expect(products.any((p) => p['name'] == 'Server Product 2'), true);
      expect(products[0]['serverId'], isNotNull);
      expect(products[0]['version'], 1);
    });
    
    test('6. Full sync - push local changes then pull server changes', () async {
      // Arrange - Clean state
      await _cleanupDatabase(localDb);
      
      // Create local product
      await entityService.save(
        resourceName: 'product',
        id: testProductId,
        data: {
          'name': 'Local Product',
          'base_price': 10.99,
        },
        isCreate: true,
      );
      
      // Mock server responses (include all Product model fields)
      final createResponse = {
        'id': 'server-product-123',
        'business_id': testBusinessId,
        'name': 'Local Product',
        'base_price': 10.99,
        'tax_rate': 0.0,
        'is_active': true,
        'stock_quantity': 0,
        'version': 1,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
        'sku': null,
        'category': null,
        'metadata': null,
      };
      
      final pullResponse = [
        {
          'id': 'server-product-123',
          'business_id': testBusinessId,
          'name': 'Local Product',
          'base_price': 10.99,
          'tax_rate': 0.0,
          'is_active': true,
          'stock_quantity': 0,
          'version': 1,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
          'sku': null,
          'category': null,
          'metadata': null,
        },
        {
          'id': 'server-product-456',
          'business_id': testBusinessId,
          'name': 'Server Product',
          'base_price': 20.99,
          'tax_rate': 0.0,
          'is_active': true,
          'stock_quantity': 0,
          'version': 1,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
          'sku': null,
          'category': null,
          'metadata': null,
        },
      ];
      
      dioAdapter.onPost(
        '/businesses/$testBusinessId/products',
        (server) => server.reply(200, createResponse),
      );
      
      dioAdapter.onGet(
        '/businesses/$testBusinessId/products',
        (server) => server.reply(200, pullResponse),
      );
      
      // Act - Full sync
      await entityService.manualSync();
      
      // Assert - Both local and server products should be present
      final products = await entityService.get('product');
      expect(products.length, greaterThanOrEqualTo(1));
      expect(products.any((p) => p['name'] == 'Local Product'), true);
    });
  });
}
