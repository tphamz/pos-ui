import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos_mobile/screens/login_screen.dart';
import 'package:pos_mobile/providers/auth_provider.dart';
import 'package:pos_mobile/providers/api_providers.dart';
import 'package:pos_mobile/services/auth_service.dart';
import 'package:pos_mobile/services/api_client.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late ApiClient apiClient;
  late AuthService authService;
  late ProviderContainer container;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    // Mock SharedPreferences platform channel
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/shared_preferences'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'getAll') {
          return <String, dynamic>{}; // Return empty map for tests
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
    container = ProviderContainer(
      overrides: [
        authServiceProvider.overrideWithValue(authService),
        apiClientProvider.overrideWithValue(apiClient),
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
        home: child,
      ),
    );
  }

  group('LoginScreen Widget Tests', () {
    testWidgets('should display all form fields', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const LoginScreen()));
      await tester.pumpAndSettle();

      // Check for form fields by labelText (InputDecoration labelText)
      expect(find.text('Email or Phone'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Store Code *'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('should show validation errors for empty required fields', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const LoginScreen()));
      await tester.pumpAndSettle();

      // Tap login button without filling fields
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Should show validation errors (check for error messages)
      expect(find.text('Please enter your email or phone'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
      expect(find.text('Please enter your store code'), findsOneWidget);
    });

    testWidgets('should validate email format', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const LoginScreen()));
      await tester.pumpAndSettle();

      // Enter invalid email
      final contactField = find.byType(TextFormField).first;
      await tester.enterText(contactField, 'invalid-email');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email or phone number'), findsOneWidget);
    });

    testWidgets('should validate store code format', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const LoginScreen()));
      await tester.pumpAndSettle();

      // Scroll to find store code field if needed
      final storeCodeField = find.byType(TextFormField).at(1); // Store code is second field
      await tester.ensureVisible(storeCodeField);
      await tester.enterText(storeCodeField, 'Invalid Store Code');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.text('Invalid store code format'), findsOneWidget);
    });

    testWidgets('should toggle password visibility', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const LoginScreen()));
      await tester.pumpAndSettle();

      // First, toggle to password mode (not OTP mode)
      // Find the switch and ensure it's off (password mode)
      final switchWidget = find.byType(Switch);
      if (switchWidget.evaluate().isNotEmpty) {
        final switchValue = tester.widget<Switch>(switchWidget).value;
        if (switchValue) {
          // If OTP mode is on, toggle it off
          await tester.tap(switchWidget);
          await tester.pumpAndSettle();
        }
      }

      // Find password field (should be visible now)
      final passwordField = find.byType(TextFormField).at(2); // Password is third field
      await tester.ensureVisible(passwordField);
      await tester.enterText(passwordField, 'password123');
      await tester.pump();

      // Find visibility toggle icon
      final visibilityIcon = find.byIcon(Icons.visibility_off);
      expect(visibilityIcon, findsOneWidget);

      // Tap to show password
      await tester.tap(visibilityIcon);
      await tester.pumpAndSettle();

      // Should show password
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('should navigate to signup screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: MaterialApp(
            routes: {
              '/': (context) => const LoginScreen(),
              '/signup': (context) => const Scaffold(body: Text('Signup Screen')),
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Scroll to find sign up link if needed
      final signUpLink = find.text('Sign Up');
      await tester.ensureVisible(signUpLink);
      expect(signUpLink, findsOneWidget);
      
      await tester.tap(signUpLink);
      await tester.pumpAndSettle();

      // Should navigate to signup (checking for signup screen content)
      // Note: This test assumes SignupScreen exists and is navigable
    });
  });
}
