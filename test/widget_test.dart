// Basic Flutter widget test for POS app
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos_mobile/main.dart';

void main() {
  testWidgets('POS app should load login screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: POSApp(),
      ),
    );

    // Wait for async initialization
    await tester.pumpAndSettle();

    // Verify that login screen is displayed
    expect(find.text('POS System'), findsWidgets);
  });
}
