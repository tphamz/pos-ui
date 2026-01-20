import 'dart:convert';
import '../database/local_db_service.dart';
import '../database/app_database.dart';
import '../repositories/resources_registry.dart';
import '../repositories/resource.dart';

/// Service for managing sync queue operations
/// Uses ResourcesRegistry to access entity repositories
class QueueService {
  final LocalDbService _localDb;
  final ResourcesRegistry _resources;
  bool _isProcessing = false;
  
  QueueService(this._localDb, this._resources);
  
  /// Enqueue an operation for sync
  /// Uses LocalDbService's addToSyncQueue which handles consolidation logic
  Future<int> enqueue({
    required String resourceName,
    required String action,
    required String entityId,
    String? serverEntityId,
    Map<String, dynamic>? entityData,
  }) async {
    return await _localDb.addToSyncQueue(
      operationType: action,
      entityType: resourceName,
      entityId: entityId,
      serverEntityId: serverEntityId,
      entityData: entityData,
    );
  }
  
  /// Process sync queue
  /// Processes pending items in FIFO order
  Future<void> processQueue() async {
    if (_isProcessing) {
      return; // Already processing
    }
    
    _isProcessing = true;
    try {
      await _processQueueInternal();
    } finally {
      _isProcessing = false;
    }
  }
  
  /// Internal method to process queue (without lock management)
  Future<void> _processQueueInternal() async {
    final pendingItems = await _localDb.getPendingSyncItems();
    
    if (pendingItems.isEmpty) {
      return; // Nothing to sync
    }
    
    print('🔄 Processing ${pendingItems.length} pending sync items'); // ignore: avoid_print
    
    for (final item in pendingItems) {
      try {
        print('📤 Syncing ${item.operationType} ${item.entityType} (ID: ${item.entityId})'); // ignore: avoid_print
        
        // Mark as syncing
        await _localDb.updateSyncQueueStatus(item.id, status: 'syncing');
        
        // Process the item
        await _processItem(item);
        
        // Mark as synced on success
        await _localDb.updateSyncQueueStatus(item.id, status: 'synced');
        
        // Remove from queue
        await _localDb.removeFromSyncQueue(item.id);
        
        print('✅ Successfully synced ${item.operationType} ${item.entityType} (ID: ${item.entityId})'); // ignore: avoid_print
      } catch (e, stackTrace) {
        print('❌ Error syncing ${item.operationType} ${item.entityType} (ID: ${item.entityId}): $e'); // ignore: avoid_print
        await _handleError(item, e);
      }
    }
  }
  
  /// Process a single queue item
  Future<void> _processItem(SyncQueueData item) async {
    // Get resource for this entity type
    final resource = _resources.get(item.entityType);
    if (resource == null) {
      throw Exception('Resource ${item.entityType} not found');
    }
    
    // Route to operation-specific handler
    switch (item.operationType) {
      case 'create':
        await _syncCreate(resource, item);
        break;
      case 'update':
        await _syncUpdate(resource, item);
        break;
      case 'delete':
        await _syncDelete(resource, item);
        break;
      default:
        throw Exception('Unknown operation type: ${item.operationType}');
    }
  }
  
  /// Sync create operation
  Future<void> _syncCreate(Resource resource, SyncQueueData item) async {
    if (item.entityData == null) {
      throw Exception('Entity data is null for create operation');
    }
    
    final entityData = jsonDecode(item.entityData!) as Map<String, dynamic>;
    final businessId = entityData['business_id'] as String? ?? 
                       entityData['businessId'] as String?;
    
    if (businessId == null) {
      throw Exception('business_id is required for create operation');
    }
    
    // Create on remote
    final result = await resource.remote.execute('create', {
      'businessId': businessId,
      'data': entityData,
    }) as Map<String, dynamic>;
    
    // Update local with server ID and version
    // Remove password from local data after successful sync (security: password no longer needed locally)
    // For tables, result might not have 'id' (tables don't have server IDs)
    final updatedData = {
      ...entityData,
      'version': result['version'] ?? 1,
      'created_at': result['created_at'] ?? entityData['created_at'],
      'updated_at': result['updated_at'] ?? entityData['updated_at'],
    };
    
    // Only add serverId if it exists (tables don't have server IDs)
    if (result['id'] != null) {
      updatedData['serverId'] = result['id'] as String;
    }
    
    // Remove password and encryption flag after successful sync
    updatedData.remove('password');
    updatedData.remove('_password_encrypted');
    
    // For table operations, pass businessId explicitly
    final upsertArgs = {
      'id': item.entityId,
      'data': updatedData,
    };
    if (resource.name == 'table') {
      upsertArgs['businessId'] = businessId;
    }
    
    await resource.local.execute('upsert', upsertArgs);
  }
  
  /// Sync update operation
  Future<void> _syncUpdate(Resource resource, SyncQueueData item) async {
    // For table operations, we need businessId
    final findOneArgs = {'id': item.entityId};
    if (resource.name == 'table') {
      // Get businessId from entityData
      final entityData = item.entityData != null
          ? jsonDecode(item.entityData!) as Map<String, dynamic>
          : <String, dynamic>{};
      final businessId = entityData['business_id'] as String? ?? 
                         entityData['businessId'] as String?;
      if (businessId != null) {
        findOneArgs['businessId'] = businessId;
      }
    }
    
    // Get latest local data (includes version for optimistic locking)
    final localData = await resource.local.execute('findOne', findOneArgs) as Map<String, dynamic>?;
    
    if (localData == null) {
      throw Exception('Entity not found locally: ${item.entityId}');
    }
    
    // Merge queue data with local data (queue data takes precedence)
    final entityData = item.entityData != null
        ? jsonDecode(item.entityData!) as Map<String, dynamic>
        : <String, dynamic>{};
    
    final mergedData = {
      ...localData,
      ...entityData,
      // Ensure version is included for optimistic locking
      'version': localData['version'] ?? 1,
    };
    
    final businessId = mergedData['business_id'] as String? ?? 
                       mergedData['businessId'] as String?;
    final serverId = mergedData['serverId'] as String?;
    
    if (businessId == null) {
      throw Exception('business_id is required for update operation');
    }
    
    if (serverId == null || serverId.isEmpty) {
      throw Exception('serverId is required for update operation');
    }
    
    // Update on remote
    final result = await resource.remote.execute('update', {
      'businessId': businessId,
      'id': serverId,
      'data': mergedData,
    }) as Map<String, dynamic>;
    
    // Update local with server response (includes new version)
    final updatedData = {
      ...mergedData,
      'version': result['version'] ?? mergedData['version'],
      'updated_at': result['updated_at'],
    };
    
    // For table operations, pass businessId explicitly
    final upsertArgs = {
      'id': item.entityId,
      'data': updatedData,
    };
    if (resource.name == 'table') {
      upsertArgs['businessId'] = businessId;
    }
    
    await resource.local.execute('upsert', upsertArgs);
  }
  
  /// Sync delete operation
  Future<void> _syncDelete(Resource resource, SyncQueueData item) async {
    final serverId = item.serverEntityId;
    
    // If no serverId, entity was never synced - just mark as synced
    if (serverId == null || serverId.isEmpty) {
      return; // Already handled by consolidation logic
    }
    
    final entityData = item.entityData != null
        ? jsonDecode(item.entityData!) as Map<String, dynamic>
        : <String, dynamic>{};
    
    final businessId = entityData['business_id'] as String?;
    
    if (businessId == null) {
      throw Exception('business_id is required for delete operation');
    }
    
    // Delete on remote
    await resource.remote.execute('delete', {
      'businessId': businessId,
      'id': serverId,
    });
    
    // Local deletion already happened before enqueueing
    // No need to delete again
  }
  
  /// Handle errors during sync
  Future<void> _handleError(SyncQueueData item, dynamic error) async {
    final retryCount = item.retryCount + 1;
    final maxRetries = 3;
    
    if (retryCount >= maxRetries) {
      // Mark as failed after max retries
      await _localDb.updateSyncQueueStatus(
        item.id,
        status: 'failed',
        retryCount: retryCount,
        errorMessage: error.toString(),
      );
    } else {
      // Retry later
      await _localDb.updateSyncQueueStatus(
        item.id,
        status: 'pending',
        retryCount: retryCount,
        errorMessage: error.toString(),
      );
    }
  }
}
