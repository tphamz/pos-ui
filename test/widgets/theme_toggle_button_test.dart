import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos_mobile/widgets/theme_toggle_button.dart';
import 'package:pos_mobile/providers/theme_provider.dart';

void main() {
  group('ThemeToggleButton', () {
    testWidgets('should display light mode icon when theme is light', (WidgetTester tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      
      final container = ProviderContainer(
        overrides: [
          themeProvider.overrideWith((ref) {
            final notifier = ThemeNotifier();
            notifier.setTheme(ThemeMode.light);
            return notifier;
          }),
        ],
      );

      // Wait for async initialization
      await Future.delayed(const Duration(milliseconds: 100));

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: MaterialApp(
            home: Scaffold(
              body: const ThemeToggleButton(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.light_mode), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode), findsNothing);
      expect(find.byIcon(Icons.brightness_auto), findsNothing);

      container.dispose();
    });

    testWidgets('should display dark mode icon when theme is dark', (WidgetTester tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      
      final container = ProviderContainer(
        overrides: [
          themeProvider.overrideWith((ref) {
            final notifier = ThemeNotifier();
            notifier.setTheme(ThemeMode.dark);
            return notifier;
          }),
        ],
      );

      // Wait for async initialization
      await Future.delayed(const Duration(milliseconds: 100));

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: MaterialApp(
            home: Scaffold(
              body: const ThemeToggleButton(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.dark_mode), findsOneWidget);
      expect(find.byIcon(Icons.light_mode), findsNothing);
      expect(find.byIcon(Icons.brightness_auto), findsNothing);

      container.dispose();
    });

    testWidgets('should display system mode icon when theme is system', (WidgetTester tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      
      final container = ProviderContainer(
        overrides: [
          themeProvider.overrideWith((ref) {
            final notifier = ThemeNotifier();
            notifier.setTheme(ThemeMode.system);
            return notifier;
          }),
        ],
      );

      // Wait for async initialization
      await Future.delayed(const Duration(milliseconds: 100));

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: MaterialApp(
            home: Scaffold(
              body: const ThemeToggleButton(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.brightness_auto), findsOneWidget);
      expect(find.byIcon(Icons.light_mode), findsNothing);
      expect(find.byIcon(Icons.dark_mode), findsNothing);

      container.dispose();
    });

    testWidgets('should toggle theme when pressed', (WidgetTester tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();

      final container = ProviderContainer();

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: MaterialApp(
            home: Scaffold(
              body: const ThemeToggleButton(),
            ),
          ),
        ),
      );

      // Initial state should be system
      expect(find.byIcon(Icons.brightness_auto), findsOneWidget);

      // Tap the button
      await tester.tap(find.byType(IconButton));
      await tester.pump();

      // Should toggle to light mode
      expect(find.byIcon(Icons.light_mode), findsOneWidget);

      container.dispose();
    });
  });
}
