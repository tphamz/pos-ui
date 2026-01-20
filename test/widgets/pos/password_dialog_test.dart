import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pos_mobile/widgets/pos/password_dialog.dart';
import 'package:pos_mobile/providers/auth_provider.dart';
import 'package:pos_mobile/providers/api_providers.dart';
import 'package:pos_mobile/services/auth_service.dart';
import 'package:pos_mobile/services/user_service.dart';
import 'package:pos_mobile/services/api_client.dart';
import 'package:pos_mobile/models/auth_models.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late ApiClient apiClient;
  late AuthService authService;
  late UserService userService;
  late ProviderContainer container;
  Completer<void>? verificationCompleter;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
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
    userService = UserService(apiClient);
    verificationCompleter = null;
    
    container = ProviderContainer(
      overrides: [
        authServiceProvider.overrideWithValue(authService),
        userServiceProvider.overrideWithValue(userService),
        apiClientProvider.overrideWithValue(apiClient),
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

  group('PasswordDialog Widget Tests', () {
    testWidgets('should display dialog with title and message', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          PasswordDialog(
            title: 'Test Title',
            message: 'Test message',
            onVerified: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test message'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('should display password input field', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          PasswordDialog(
            title: 'Test Title',
            message: 'Test message',
            onVerified: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byIcon(Icons.lock), findsOneWidget);
    });

    testWidgets('should show validation error for empty password', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          PasswordDialog(
            title: 'Test Title',
            message: 'Test message',
            onVerified: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find and tap the Verify button
      final verifyButton = find.text('Verify');
      expect(verifyButton, findsOneWidget);
      await tester.tap(verifyButton);
      await tester.pumpAndSettle();

      // Should show validation error
      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('should show error message on invalid password', (WidgetTester tester) async {
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

      // Mock failed login
      dioAdapter.onPost(
        '/auth/login',
        (server) => server.reply(401, {
          'error': 'Invalid credentials',
          'message': 'Invalid password',
        }),
      );

      await tester.pumpWidget(
        createTestWidget(
          PasswordDialog(
            title: 'Test Title',
            message: 'Test message',
            onVerified: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter password
      final passwordField = find.byType(TextFormField);
      await tester.enterText(passwordField, 'wrongpassword');
      await tester.pumpAndSettle();

      // Tap Verify button
      await tester.tap(find.text('Verify'));
      await tester.pumpAndSettle();

      // Should show error message
      expect(find.text('Invalid password. Please try again.'), findsOneWidget);
    });

    testWidgets('should call onVerified on successful password verification', (WidgetTester tester) async {
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

      // Mock successful login
      dioAdapter.onPost(
        '/auth/login',
        (server) => server.reply(200, {
          'token': 'new-token',
          'user_id': 'user-123',
          'user_type': 'staff',
          'business_id': 'business-123',
          'store_code': 'test-store',
          'expires_at': DateTime.now().add(const Duration(hours: 1)).toIso8601String(),
        }),
      );

      verificationCompleter = Completer<void>();
      
      await tester.pumpWidget(
        createTestWidget(
          PasswordDialog(
            title: 'Test Title',
            message: 'Test message',
            onVerified: () {
              verificationCompleter?.complete();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter password
      final passwordField = find.byType(TextFormField);
      await tester.enterText(passwordField, 'correctpassword');
      await tester.pumpAndSettle();

      // Tap Verify button
      await tester.tap(find.text('Verify'));
      
      // Wait for verification to complete
      await tester.pump();
      await verificationCompleter!.future.timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw TimeoutException('Verification callback not called');
        },
      );
      await tester.pumpAndSettle();

      // Should have called onVerified callback
      expect(verificationCompleter!.isCompleted, true);
    });

    testWidgets('should show loading indicator during verification', (WidgetTester tester) async {
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

      // Mock login with immediate response (no delay to avoid timer issues)
      dioAdapter.onPost(
        '/auth/login',
        (server) => server.reply(200, {
          'token': 'new-token',
          'user_id': 'user-123',
          'user_type': 'staff',
          'business_id': 'business-123',
          'store_code': 'test-store',
          'expires_at': DateTime.now().add(const Duration(hours: 1)).toIso8601String(),
        }),
      );

      await tester.pumpWidget(
        createTestWidget(
          PasswordDialog(
            title: 'Test Title',
            message: 'Test message',
            onVerified: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter password
      final passwordField = find.byType(TextFormField);
      await tester.enterText(passwordField, 'password');
      await tester.pumpAndSettle();

      // Tap Verify button
      await tester.tap(find.text('Verify'));
      await tester.pump(); // First pump to trigger state change

      // Should show loading indicator briefly
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // Complete the async operation
      await tester.pumpAndSettle();
    });

    testWidgets('should close dialog when cancel is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          PasswordDialog(
            title: 'Test Title',
            message: 'Test message',
            onVerified: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Cancel button
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Dialog should be closed
      expect(find.text('Test Title'), findsNothing);
    });

    testWidgets('should close dialog when close icon is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          PasswordDialog(
            title: 'Test Title',
            message: 'Test message',
            onVerified: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap close icon
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // Dialog should be closed
      expect(find.text('Test Title'), findsNothing);
    });
  });
}
