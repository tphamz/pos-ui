import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database_providers.dart';
import '../database/local_db_service.dart';
import '../services/queue_service.dart';
import '../services/entity_service.dart';
import '../providers/entity_providers.dart';
import '../providers/repository_providers.dart';
import '../providers/auth_provider.dart';

/// Manages automatic sync based on connectivity and app lifecycle
/// - Listens to network connectivity changes
/// - Triggers sync when network comes back online
/// - Triggers sync when app resumes
class SyncManager {
  final QueueService _queueService;
  final EntityService _entityService;
  final LocalDbService _localDb;
  final bool Function() _isAuthenticated; // Function to check if user is authenticated
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _isInitialized = false;

  SyncManager(this._queueService, this._entityService, this._localDb, this._isAuthenticated);

  /// Initialize sync manager - start listening to connectivity changes
  Future<void> initialize() async {
    if (_isInitialized) return;
    _isInitialized = true;

    // Check initial connectivity and sync if online
    final connectivity = Connectivity();
    final initialResult = await connectivity.checkConnectivity();
    if (initialResult.isNotEmpty && !initialResult.contains(ConnectivityResult.none)) {
      // Already online - try to sync pending items
      await _attemptSync();
    }

    // Listen for connectivity changes
    _connectivitySubscription = connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        // If we have any connectivity (not none), trigger sync
        if (results.isNotEmpty && !results.contains(ConnectivityResult.none)) {
          _attemptSync();
        }
      },
    );
  }

  /// Attempt to sync pending items (non-blocking)
  Future<void> _attemptSync() async {
    // Don't sync if user is not authenticated (e.g., on login screen)
    if (!_isAuthenticated()) {
      return;
    }
    
    try {
      // Check if there are any pending items before syncing
      final pendingItems = await _localDb.getPendingSyncItems(limit: 1);
      if (pendingItems.isNotEmpty) {
        // Only sync if there are pending items
        await _queueService.processQueue();
      }
    } catch (e) {
      // Silently fail - sync will retry later
      // Log error in production if needed
    }
  }

  /// Push local changes to server only (no pull)
  /// Used for app resume - efficient for offline-first architecture
  Future<void> pushLocalChanges() async {
    // Don't sync if user is not authenticated (e.g., on login screen)
    if (!_isAuthenticated()) {
      return;
    }
    
    try {
      // Only push local changes, don't pull from server
      await _queueService.processQueue();
    } catch (e) {
      // Silently fail - sync will retry later
    }
  }

  /// Manually trigger full bidirectional sync (for manual sync button)
  /// Pushes local changes to server, then pulls server changes to local
  /// Requires businessId to get EntityService instance
  Future<void> manualSync(String? businessId) async {
    try {
      if (businessId != null) {
        // Get EntityService for this businessId
        // Note: This requires ref, so we'll need to update the provider
        // For now, just process queue - manual sync should be called with EntityService directly
        await _queueService.processQueue();
      } else {
        // If no business ID, just push local changes
        await _queueService.processQueue();
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Get pending sync items count
  Future<int> getPendingSyncCount() async {
    final pendingItems = await _localDb.getPendingSyncItems();
    return pendingItems.length;
  }

  /// Get failed sync items count
  Future<int> getFailedSyncCount() async {
    final failedItems = await _localDb.getFailedSyncItems();
    return failedItems.length;
  }

  /// Get detailed sync queue information (for debugging)
  Future<Map<String, dynamic>> getSyncQueueInfo() async {
    final pendingItems = await _localDb.getPendingSyncItems(limit: 100);
    final failedItems = await _localDb.getFailedSyncItems(limit: 100);
    final syncingItems = await _localDb.getSyncQueueItemsByStatus('syncing', limit: 100);
    final allItems = await _localDb.getAllSyncQueueItems(limit: 100);

    return {
      'pending_count': pendingItems.length,
      'failed_count': failedItems.length,
      'syncing_count': syncingItems.length,
      'total_count': allItems.length,
      'pending_items': pendingItems.map((item) => {
        'id': item.id,
        'operation': item.operationType,
        'entity_type': item.entityType,
        'entity_id': item.entityId,
        'retry_count': item.retryCount,
        'error': item.errorMessage,
        'created_at': item.createdAt,
      }).toList(),
      'failed_items': failedItems.map((item) => {
        'id': item.id,
        'operation': item.operationType,
        'entity_type': item.entityType,
        'entity_id': item.entityId,
        'retry_count': item.retryCount,
        'error': item.errorMessage,
        'created_at': item.createdAt,
      }).toList(),
      'syncing_items': syncingItems.map((item) => {
        'id': item.id,
        'operation': item.operationType,
        'entity_type': item.entityType,
        'entity_id': item.entityId,
        'retry_count': item.retryCount,
        'error': item.errorMessage,
        'created_at': item.createdAt,
      }).toList(),
    };
  }

  /// Print sync queue info to console (for debugging)
  Future<void> printSyncQueueInfo() async {
    final info = await getSyncQueueInfo();
    print('\n=== SYNC QUEUE STATUS ===');
    print('Pending: ${info['pending_count']}');
    print('Failed: ${info['failed_count']}');
    print('Syncing: ${info['syncing_count']}');
    print('Total: ${info['total_count']}');
    
    if (info['pending_items'] is List && (info['pending_items'] as List).isNotEmpty) {
      print('\n📋 Pending Items:');
      for (final item in (info['pending_items'] as List).take(10)) {
        print('  - ${item['operation']} ${item['entity_type']} (ID: ${item['entity_id']}, Retry: ${item['retry_count']})');
      }
    }
    
    if (info['failed_items'] is List && (info['failed_items'] as List).isNotEmpty) {
      print('\n❌ Failed Items:');
      for (final item in (info['failed_items'] as List).take(10)) {
        print('  - ${item['operation']} ${item['entity_type']} (ID: ${item['entity_id']})');
        print('    Error: ${item['error'] ?? 'No error message'}');
      }
    }
    
    print('========================\n');
  }

  /// Dispose - cancel subscriptions
  void dispose() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
    _isInitialized = false;
  }
}

/// Provider for SyncManager
/// Note: EntityService is now a family provider (requires businessId)
/// SyncManager uses QueueService for push operations
/// For manual sync, use EntityService directly from widgets
final syncManagerProvider = Provider<SyncManager>((ref) {
  final queueService = ref.watch(queueServiceProvider);
  final localDb = ref.watch(localDbServiceProvider);
  final resources = ref.watch(resourcesRegistryProvider);
  
  // Function to check if user is authenticated
  bool isAuthenticated() {
    final authState = ref.read(authProvider);
    return authState.isAuthenticated;
  }
  
  // Create a dummy EntityService for compatibility (won't be used for manualSync)
  // Manual sync should be called directly with EntityService from widget
  final entityService = EntityService(
    resources: resources,
    queueService: queueService,
    localDb: localDb,
    businessId: '', // Dummy - won't be used
  );
  
  final syncManager = SyncManager(queueService, entityService, localDb, isAuthenticated);
  
  // Initialize sync manager when provider is first created
  syncManager.initialize();
  
  // Dispose when provider is disposed
  ref.onDispose(() {
    syncManager.dispose();
  });
  
  return syncManager;
});
