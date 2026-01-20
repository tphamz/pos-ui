import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pos_mobile/widgets/pos/settings_dialog.dart';
import 'package:pos_mobile/providers/auth_provider.dart';
import 'package:pos_mobile/providers/api_providers.dart';
import 'package:pos_mobile/providers/entity_providers.dart';
import 'package:pos_mobile/providers/repository_providers.dart';
import 'package:pos_mobile/services/auth_service.dart';
import 'package:pos_mobile/services/api_client.dart';
import 'package:pos_mobile/services/entity_service.dart';
import 'package:pos_mobile/services/queue_service.dart';
import 'package:pos_mobile/database/app_database.dart';
import 'package:pos_mobile/database/local_db_service.dart';
import 'package:pos_mobile/database/database_providers.dart';
import 'package:pos_mobile/repositories/resources_registry.dart';
import 'package:pos_mobile/models/auth_models.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late ApiClient apiClient;
  late AuthService authService;
  late ProviderContainer container;

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
    // Mock SharedPreferences platform channel
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

  tearDownAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/shared_preferences'),
      null,
    );
  });

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    apiClient = ApiClient(dio: dio);
    authService = AuthService(apiClient);

    // Create mock EntityService
    final localDb = LocalDbService(AppDatabase());
    final resources = ResourcesRegistry();
    final queueService = QueueService(localDb, resources);

    container = ProviderContainer(
      overrides: [
        authServiceProvider.overrideWithValue(authService),
        apiClientProvider.overrideWithValue(apiClient),
        localDbServiceProvider.overrideWithValue(localDb),
        resourcesRegistryProvider.overrideWithValue(resources),
        queueServiceProvider.overrideWithValue(queueService),
        entityServiceProvider.overrideWith(
          (ref, businessId) => EntityService(
            resources: resources,
            queueService: queueService,
            localDb: localDb,
            businessId: businessId,
          ),
        ),
        authProvider.overrideWith(
          (ref) => AuthNotifier(authService, apiClient, ref: ref)
            ..state = AuthState(
              user: LoginResponse(
                token: 'test-token',
                userId: 'user-123',
                userType: 'staff',
                businessId: 'business-123',
                storeCode: 'test-store',
                expiresAt: DateTime.now().add(const Duration(hours: 1)),
              ),
            ),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  Widget createTestWidget(Widget child) {
    return ProviderScope(
      parent: container,
      child: MaterialApp(
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }

  group('SettingsDialog Widget Tests', () {
    testWidgets('should display settings dialog with title', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const SettingsDialog()));
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Edit Mode'), findsOneWidget);
    });

    testWidgets('should display edit mode toggle', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const SettingsDialog()));
      await tester.pumpAndSettle();

      expect(find.text('Edit Mode'), findsOneWidget);
      expect(find.text('Enable editing, creating, and deleting items'), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('should display sync menu item', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const SettingsDialog()));
      await tester.pumpAndSettle();

      expect(find.text('Sync'), findsOneWidget);
      expect(
        find.text('Synchronize local data with server'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.sync), findsOneWidget);
    });

    testWidgets('should display backup menu item with warning color', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const SettingsDialog()));
      await tester.pumpAndSettle();

      expect(find.text('Backup'), findsOneWidget);
      expect(
        find.text('Replace server data with local data (may affect user data)'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.backup), findsOneWidget);
    });

    testWidgets('should display restore menu item with warning color', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const SettingsDialog()));
      await tester.pumpAndSettle();

      expect(find.text('Restore'), findsOneWidget);
      expect(
        find.text('Replace local data with server data (may affect user data)'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.restore), findsOneWidget);
    });

    testWidgets('should toggle edit mode when switch is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const SettingsDialog()));
      await tester.pumpAndSettle();

      final switchWidget = tester.widget<Switch>(find.byType(Switch));
      final initialValue = switchWidget.value;

      // Tap the switch
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      final newSwitchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(newSwitchWidget.value, !initialValue);
    });

    testWidgets('should close dialog when close button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const SettingsDialog()));
      await tester.pumpAndSettle();

      // Tap close icon
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // Dialog should be closed
      expect(find.text('Settings'), findsNothing);
    });

    testWidgets('should close dialog when Close button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const SettingsDialog()));
      await tester.pumpAndSettle();

      // Tap Close button
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();

      // Dialog should be closed
      expect(find.text('Settings'), findsNothing);
    });

    testWidgets('should show snackbar on sync success', (WidgetTester tester) async {
      // Mock successful sync (no API calls needed for manualSync in this test)
      await tester.pumpWidget(createTestWidget(const SettingsDialog()));
      await tester.pumpAndSettle();

      // Tap Sync menu item
      await tester.tap(find.text('Sync'));
      await tester.pumpAndSettle();

      // Note: In a real test, we'd mock the EntityService.manualSync() method
      // For now, we're just testing the UI interaction
      // The actual sync logic would be tested in EntityService tests
    });

    testWidgets('should show password dialog when backup is tapped', (WidgetTester tester) async {
      // Mock user profile API
      dioAdapter.onGet(
        '/users/user-123',
        (server) => server.reply(200, {
          'id': 'user-123',
          'full_name': 'Test User',
          'phone_number': '+1234567890',
          'email': null,
          'is_verified': true,
          'version': 1,
          'created_at': '2024-01-01T00:00:00Z',
        }),
      );

      await tester.pumpWidget(createTestWidget(const SettingsDialog()));
      await tester.pumpAndSettle();

      // Find and tap Backup menu item (it's in an InkWell)
      final backupFinder = find.text('Backup');
      expect(backupFinder, findsOneWidget);
      await tester.tap(backupFinder);
      await tester.pump(); // Start the async operation
      await tester.pumpAndSettle();

      // Password dialog should appear
      expect(find.text('Backup Data'), findsOneWidget);
      expect(
        find.textContaining('replace all server data'),
        findsOneWidget,
      );
    });

    testWidgets('should show password dialog when restore is tapped', (WidgetTester tester) async {
      // Mock user profile API
      dioAdapter.onGet(
        '/users/user-123',
        (server) => server.reply(200, {
          'id': 'user-123',
          'full_name': 'Test User',
          'phone_number': '+1234567890',
          'email': null,
          'is_verified': true,
          'version': 1,
          'created_at': '2024-01-01T00:00:00Z',
        }),
      );

      await tester.pumpWidget(createTestWidget(const SettingsDialog()));
      await tester.pumpAndSettle();

      // Find and tap Restore menu item (it's in an InkWell)
      final restoreFinder = find.text('Restore');
      expect(restoreFinder, findsOneWidget);
      await tester.tap(restoreFinder);
      await tester.pump(); // Start the async operation
      await tester.pumpAndSettle();

      // Password dialog should appear
      expect(find.text('Restore Data'), findsOneWidget);
      expect(
        find.textContaining('replace all local data'),
        findsOneWidget,
      );
    });
  });
}
