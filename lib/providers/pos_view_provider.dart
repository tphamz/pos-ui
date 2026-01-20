import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider to manage the active view in the POS screen
/// This allows the FeatureMenu to control what's shown in the CenterPanel
final posViewProvider = StateProvider<String>((ref) => 'pos');

/// Available view IDs
class POSView {
  static const String pos = 'pos'; // Main POS feature
  static const String dashboard = 'dashboard';
  static const String orders = 'orders';
  static const String reports = 'reports';
  static const String schedule = 'schedule';
  static const String customers = 'customers';
  static const String inventory = 'inventory';
  static const String payments = 'payments';
  static const String timeClock = 'timeclock';
  static const String help = 'help';
  static const String settings = 'settings';
  
  // Center panel tabs (shown when pos is active)
  static const String products = 'products';
  static const String tables = 'tables';
  static const String staff = 'staff';
}
