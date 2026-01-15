import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos_mobile/screens/signup_screen.dart';
import 'package:pos_mobile/providers/api_providers.dart';
import 'package:pos_mobile/services/user_service.dart';
import 'package:pos_mobile/services/api_client.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late ApiClient apiClient;
  late UserService userService;
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
    userService = UserService(apiClient);
    container = ProviderContainer(
      overrides: [
        userServiceProvider.overrideWithValue(userService),
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

  group('SignupScreen Widget Tests', () {
    testWidgets('should display all form fields', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const SignupScreen()));
      await tester.pumpAndSettle();

      // Check for form fields by labelText (InputDecoration labelText)
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Business Name *'), findsOneWidget);
      expect(find.text('Email (Optional)'), findsOneWidget);
      expect(find.text('Phone (Optional)'), findsOneWidget);
      expect(find.text('Password (Optional)'), findsOneWidget);
      expect(find.text('Confirm Password (Optional)'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets('should show validation errors for empty required fields', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const SignupScreen()));
      await tester.pumpAndSettle();

      // Tap sign up button without filling required fields
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      // Should show validation errors
      expect(find.text('Please enter your full name'), findsOneWidget);
      expect(find.text('Please enter your business name'), findsOneWidget);
    });

    testWidgets('should require either email or phone number', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const SignupScreen()));
      await tester.pumpAndSettle();

      // Fill required fields but leave both email and phone empty
      final fullNameField = find.byType(TextFormField).at(0);
      final businessNameField = find.byType(TextFormField).at(1);
      
      await tester.ensureVisible(fullNameField);
      await tester.enterText(fullNameField, 'John Doe');
      await tester.ensureVisible(businessNameField);
      await tester.enterText(businessNameField, 'My Business');
      
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      expect(find.text('Please provide either email or phone number'), findsOneWidget);
    });

    testWidgets('should validate email format', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const SignupScreen()));
      await tester.pumpAndSettle();

      // Enter invalid email
      final emailField = find.byType(TextFormField).at(2);
      await tester.ensureVisible(emailField);
      await tester.enterText(emailField, 'invalid-email');
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email'), findsOneWidget);
    });

    testWidgets('should validate phone number format', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const SignupScreen()));

      // Enter invalid phone
      final phoneField = find.byType(TextFormField).at(3);
      await tester.enterText(phoneField, '123');
      await tester.tap(find.text('Sign Up'));
      await tester.pump();

      expect(find.text('Please enter a valid phone number'), findsOneWidget);
    });

    testWidgets('should validate password match', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const SignupScreen()));
      await tester.pumpAndSettle();

      // Fill required fields
      final fullNameField = find.byType(TextFormField).at(0);
      final businessNameField = find.byType(TextFormField).at(1);
      final emailField = find.byType(TextFormField).at(2);
      final passwordField = find.byType(TextFormField).at(4);
      final confirmPasswordField = find.byType(TextFormField).at(5);

      await tester.ensureVisible(fullNameField);
      await tester.enterText(fullNameField, 'John Doe');
      await tester.ensureVisible(businessNameField);
      await tester.enterText(businessNameField, 'My Business');
      await tester.ensureVisible(emailField);
      await tester.enterText(emailField, 'john@example.com');
      await tester.ensureVisible(passwordField);
      await tester.enterText(passwordField, 'password123');
      await tester.ensureVisible(confirmPasswordField);
      await tester.enterText(confirmPasswordField, 'password456');
      
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('should toggle password visibility', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const SignupScreen()));
      await tester.pumpAndSettle();

      // Find password field
      final passwordField = find.byType(TextFormField).at(4);
      await tester.ensureVisible(passwordField);
      await tester.enterText(passwordField, 'password123');
      await tester.pump();

      // Find visibility toggle icons (should be 2 - one for password, one for confirm)
      final visibilityIcons = find.byIcon(Icons.visibility_off);
      expect(visibilityIcons, findsNWidgets(2));

      // Tap first visibility toggle
      await tester.tap(visibilityIcons.first);
      await tester.pumpAndSettle();

      // Should show password
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('should successfully submit valid form', (WidgetTester tester) async {
      dioAdapter.onPost(
        '/auth/signup',
        (server) => server.reply(
          201,
          {
            'user': {
              'id': 'user-123',
              'full_name': 'John Doe',
              'email': 'john@example.com',
              'is_verified': false,
              'created_at': '2024-01-01T00:00:00Z',
            },
            'business': {
              'id': 'business-123',
              'name': 'My Business',
              'store_code': 'my-business',
              'currency': 'USD',
              'timezone': 'America/New_York',
              'status': 'active',
              'created_at': '2024-01-01T00:00:00Z',
              'updated_at': '2024-01-01T00:00:00Z',
            },
          },
        ),
      );

      await tester.pumpWidget(createTestWidget(const SignupScreen()));
      await tester.pumpAndSettle();

      // Fill all fields
      final fullNameField = find.byType(TextFormField).at(0);
      final businessNameField = find.byType(TextFormField).at(1);
      final emailField = find.byType(TextFormField).at(2);
      final passwordField = find.byType(TextFormField).at(4);
      final confirmPasswordField = find.byType(TextFormField).at(5);

      await tester.ensureVisible(fullNameField);
      await tester.enterText(fullNameField, 'John Doe');
      await tester.ensureVisible(businessNameField);
      await tester.enterText(businessNameField, 'My Business');
      await tester.ensureVisible(emailField);
      await tester.enterText(emailField, 'john@example.com');
      await tester.ensureVisible(passwordField);
      await tester.enterText(passwordField, 'password123');
      await tester.ensureVisible(confirmPasswordField);
      await tester.enterText(confirmPasswordField, 'password123');
      
      await tester.tap(find.text('Sign Up'));
      await tester.pump(); // Start the async operation
      await tester.pump(const Duration(seconds: 1)); // Wait for async to complete
      await tester.pumpAndSettle(); // Wait for navigation

      // Should show success message in SnackBar
      expect(find.text('Account created successfully! Please login.'), findsOneWidget);
    });
  });
}
