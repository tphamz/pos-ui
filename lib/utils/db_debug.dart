import 'dart:convert';
import '../database/database_providers.dart';
import '../database/app_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Debug utility to inspect local database and sync queue
class DbDebug {
  static Future<void> printDbStatus(Ref ref) async {
    final localDb = ref.read(localDbServiceProvider);
    final db = ref.read(appDatabaseProvider);

    print('\n=== LOCAL DATABASE STATUS ===\n');

    // Check sync queue
    try {
      final pendingItems = await localDb.getPendingSyncItems();
      final failedItems = await localDb.getFailedSyncItems();
      
      print('📋 Sync Queue Status:');
      print('  Pending items: ${pendingItems.length}');
      print('  Failed items: ${failedItems.length}');
      
      if (pendingItems.isNotEmpty) {
        print('\n  Pending items:');
        for (final item in pendingItems.take(10)) {
          print('    - ${item.operationType} ${item.entityType} (ID: ${item.entityId}, Retry: ${item.retryCount})');
          if (item.errorMessage != null) {
            print('      Error: ${item.errorMessage}');
          }
        }
      }
      
      if (failedItems.isNotEmpty) {
        print('\n  Failed items:');
        for (final item in failedItems.take(10)) {
          print('    - ${item.operationType} ${item.entityType} (ID: ${item.entityId})');
          print('      Error: ${item.errorMessage ?? "No error message"}');
        }
      }
    } catch (e) {
      print('  Error reading sync queue: $e');
    }

    // Check local data counts
    try {
      final products = await localDb.getProducts('dummy'); // Will use auth state
      final staff = await localDb.getStaff('dummy');
      final tables = await localDb.getTables('dummy');
      final tickets = await db.select(db.localTickets).get();
      
      print('\n📊 Local Data Counts:');
      print('  Products: ${products.length}');
      print('  Staff: ${staff.length}');
      print('  Tables: ${tables.length}');
      print('  Tickets: ${tickets.length}');
      
      // Check unsynced items
      final unsyncedProducts = products.where((p) => p['isSynced'] == 0 || p['isSynced'] == false).length;
      final unsyncedStaff = staff.where((s) => s['isSynced'] == 0 || s['isSynced'] == false).length;
      
      print('\n🔄 Unsynced Items:');
      print('  Unsynced Products: $unsyncedProducts');
      print('  Unsynced Staff: $unsyncedStaff');
      
    } catch (e) {
      print('  Error reading local data: $e');
    }
    
    print('\n==============================\n');
  }
}
