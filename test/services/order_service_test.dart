import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import '../../lib/database/app_database.dart';
import '../../lib/database/local_db_service.dart';
import '../../lib/repositories/resources_registry.dart';
import '../../lib/services/queue_service.dart';
import '../../lib/services/entity_service.dart';
import '../../lib/services/order_service.dart';
import '../../lib/services/api_client.dart';
import '../../lib/models/order_models.dart';

/// Tests for OrderService read operations (using EntityService)
void main() {
  group('OrderService Tests', () {
    late AppDatabase db;
    late LocalDbService localDb;
    late Dio dio;
    late DioAdapter dioAdapter;
    late ApiClient apiClient;
    late ResourcesRegistry resourcesRegistry;
    late QueueService queueService;
    late EntityService entityService;
    late OrderService orderService;
    
    const String testBusinessId = 'test-business-123';
    
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
      
      orderService = OrderService(apiClient);
    });
    
    tearDown(() async {
      await db.close();
    });
    
    test('1. Get orders - returns from local first (offline-first)', () async {
      // Create a ticket/order locally
      await entityService.save(
        resourceName: 'ticket',
        id: 'ticket-1',
        data: {
          'id': 'ticket-1',
          'order_number': 'ORD-001',
          'status': 'completed',
          'business_id': testBusinessId,
          'items': [],
          'subtotal': 10.0,
          'tax_amount': 1.0,
          'total_amount': 11.0,
          'paid_amount': 11.0,
        },
        isCreate: true,
      );
      
      // Get orders - should return from local
      final orders = await orderService.getOrders(testBusinessId, entityService);
      
      expect(orders.length, equals(1));
      expect(orders[0].orderNumber, equals('ORD-001'));
      expect(orders[0].status, equals('completed'));
    });
    
    test('2. Get orders - filters by status', () async {
      // Create multiple tickets with different statuses
      await entityService.save(
        resourceName: 'ticket',
        id: 'ticket-1',
        data: {
          'id': 'ticket-1',
          'order_number': 'ORD-001',
          'status': 'completed',
          'business_id': testBusinessId,
          'items': [],
          'subtotal': 10.0,
          'tax_amount': 1.0,
          'total_amount': 11.0,
          'paid_amount': 11.0,
        },
        isCreate: true,
      );
      
      await entityService.save(
        resourceName: 'ticket',
        id: 'ticket-2',
        data: {
          'id': 'ticket-2',
          'order_number': 'ORD-002',
          'status': 'cancelled',
          'business_id': testBusinessId,
          'items': [],
          'subtotal': 20.0,
          'tax_amount': 2.0,
          'total_amount': 22.0,
          'paid_amount': 0.0,
        },
        isCreate: true,
      );
      
      // Get only completed orders
      final completedOrders = await orderService.getOrders(
        testBusinessId,
        entityService,
        status: 'completed',
      );
      
      expect(completedOrders.length, equals(1));
      expect(completedOrders[0].status, equals('completed'));
    });
    
    test('3. Get order by ID - returns from local first', () async {
      // Create a ticket/order locally
      await entityService.save(
        resourceName: 'ticket',
        id: 'ticket-1',
        data: {
          'id': 'ticket-1',
          'order_number': 'ORD-001',
          'status': 'completed',
          'business_id': testBusinessId,
          'items': [],
          'subtotal': 10.0,
          'tax_amount': 1.0,
          'total_amount': 11.0,
          'paid_amount': 11.0,
        },
        isCreate: true,
      );
      
      // Get order by ID
      final order = await orderService.getOrder(
        testBusinessId,
        'ticket-1',
        entityService,
      );
      
      expect(order, isNotNull);
      expect(order!.orderNumber, equals('ORD-001'));
      expect(order.status, equals('completed'));
    });
    
    test('4. Get orders - auto-pulls from server if local is empty', () async {
      // Mock server response
      dioAdapter.onGet(
        '/businesses/$testBusinessId/orders',
        (server) => server.reply(200, [
          {
            'id': 'order-1',
            'business_id': testBusinessId,
            'order_number': 'ORD-001',
            'status': 'completed',
            'subtotal': 10.0,
            'tax_amount': 1.0,
            'total_amount': 11.0,
            'paid_amount': 11.0,
            'items': [],
            'version': 1,
          },
        ]),
      );
      
      // Get orders - local is empty, should auto-pull
      final orders = await orderService.getOrders(testBusinessId, entityService);
      
      expect(orders.length, equals(1));
      expect(orders[0].orderNumber, equals('ORD-001'));
    });
  });
}
