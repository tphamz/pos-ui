import '../repositories/resources_registry.dart';
import 'queue_service.dart';
import '../database/local_db_service.dart';
import 'api_client.dart';

/// Main service for coordinating entity operations
/// Handles push (local → queue), pull (remote → local), and sync operations
/// Takes businessId to simplify API - no need for Offline*Service wrappers
class EntityService {
  final ResourcesRegistry _resources;
  final QueueService _queueService;
  final LocalDbService _localDb;
  final String _businessId;
  
  EntityService({
    required ResourcesRegistry resources,
    required QueueService queueService,
    required LocalDbService localDb,
    required String businessId,
  }) : _resources = resources,
       _queueService = queueService,
       _localDb = localDb,
       _businessId = businessId;
  
  /// Save entity (create or update) - offline-first
  /// Convenience method that handles businessId automatically
  Future<Map<String, dynamic>> save({
    required String resourceName,
    required String id,
    required Map<String, dynamic> data,
    bool isCreate = true,
  }) async {
    // Ensure businessId is in data
    final dataWithBusinessId = {
      ...data,
      'business_id': _businessId,
      'id': id,
    };

    await _push(
      resourceName: resourceName,
      action: isCreate ? 'create' : 'update',
      entityId: id,
      data: dataWithBusinessId,
    );

    return dataWithBusinessId;
  }

  /// Delete entity - offline-first
  /// Convenience method that handles serverId lookup and businessId
  Future<void> delete(String resourceName, String entityId) async {
    final resource = _resources.get(resourceName);
    if (resource == null) {
      throw Exception('Resource $resourceName not found');
    }
    
    // IMPORTANT: Get entity data (including serverId) BEFORE deleting from local DB
    // For table operations, pass businessId explicitly
    final findOneArgs = {'id': entityId};
    if (resourceName == 'table') {
      findOneArgs['businessId'] = _businessId;
    }
    final entity = await resource.local.execute('findOne', findOneArgs) as Map<String, dynamic>?;
    
    String? serverId;
    if (entity != null) {
      serverId = entity['serverId'] as String?;
    }
    
    // Let _push() handle the delete operation (local delete + enqueue + sync)
    await _push(
      resourceName: resourceName,
      action: 'delete',
      entityId: entityId,
      data: {'business_id': _businessId},
      serverEntityId: serverId,
    );
  }

  /// Get all entities of a resource type from local DB
  /// If local DB is empty, automatically pulls from server and saves to local
  /// Convenience method that handles businessId automatically
  Future<List<Map<String, dynamic>>> get(String resourceName) async {
    final resource = _resources.get(resourceName);
    if (resource == null) {
      throw Exception('Resource $resourceName not found');
    }
    
    // Try local first (offline-first)
    final localData = await resource.local.execute('findMany', {
      'businessId': _businessId,
    }) as List<Map<String, dynamic>>;
    
    // If local is empty, try to pull from server
    if (localData.isEmpty) {
      try {
        await _pull(resourceName, _businessId);
        // After pulling, get the data again from local
        return await resource.local.execute('findMany', {
          'businessId': _businessId,
        }) as List<Map<String, dynamic>>;
      } catch (e) {
        // If pull fails (network error, etc.), return empty list
        // This maintains offline-first behavior - don't fail if offline
        return [];
      }
    }
    
    return localData;
  }

  /// Get a single entity by ID from local DB
  /// If not found locally, tries to pull from server first (for the resource type)
  /// Convenience method that handles businessId automatically
  Future<Map<String, dynamic>?> getOne(String resourceName, String id) async {
    final resource = _resources.get(resourceName);
    if (resource == null) {
      throw Exception('Resource $resourceName not found');
    }
    
    // For table operations, pass businessId explicitly
    final findOneArgs = {'id': id};
    if (resourceName == 'table') {
      findOneArgs['businessId'] = _businessId;
    }
    
    // Try local first (offline-first)
    final localData = await resource.local.execute('findOne', findOneArgs) as Map<String, dynamic>?;
    
    // If not found locally, try to pull from server
    if (localData == null) {
      try {
        await _pull(resourceName, _businessId);
        // After pulling, try to get the data again from local
        return await resource.local.execute('findOne', findOneArgs) as Map<String, dynamic>?;
      } catch (e) {
        // If pull fails (network error, etc.), return null
        // This maintains offline-first behavior - don't fail if offline
        return null;
      }
    }
    
    return localData;
  }


  /// Internal push method - Save locally and enqueue for sync
  /// This is the offline-first pattern - save locally immediately, sync later
  Future<void> _push({
    required String resourceName,
    required String action,
    required String entityId,
    required Map<String, dynamic> data,
    String? serverEntityId,
  }) async {
    final resource = _resources.get(resourceName);
    if (resource == null) {
      throw Exception('Resource $resourceName not found');
    }
    
    // Execute locally immediately (offline-first)
    // For table operations, pass businessId explicitly
    final executeArgs = {
      'id': entityId,
      'data': data,
    };
    if (resourceName == 'table') {
      executeArgs['businessId'] = _businessId;
    }
    await resource.local.execute(action, executeArgs);
    
    // Enqueue for remote sync
    await _queueService.enqueue(
      resourceName: resourceName,
      action: action,
      entityId: entityId,
      serverEntityId: serverEntityId,
      entityData: data,
    );
    
    // Try to sync immediately if online (non-blocking)
    try {
      await _queueService.processQueue();
    } catch (e) {
      // Silently fail - will sync later when online
      // Queue is already created, so it will be processed next time
    }
  }
  
  /// Pull: Fetch from remote and save locally
  /// Used to sync server changes to local database
  /// Convenience method that uses internal businessId
  Future<void> pull(String resourceName) async {
    await _pull(resourceName, _businessId);
  }

  /// Internal pull method
  Future<void> _pull(String resourceName, String businessId) async {
    final resource = _resources.get(resourceName);
    if (resource == null) {
      throw Exception('Resource $resourceName not found');
    }
    
    // Fetch from remote
    final values = await resource.remote.execute('findMany', {
      'businessId': businessId,
    }) as List<Map<String, dynamic>>;
    
    // Upsert locally (creates or updates)
    for (final value in values) {
      // Use server ID as local ID if no local ID mapping exists
      // In a real implementation, you might want to maintain a mapping
      final localIdValue = value['id'] as String? ?? value['serverId'] as String?;
      if (localIdValue == null) {
        throw Exception('Entity ID is required');
      }
      final localId = localIdValue;
      
      // Ensure business_id is in the data (required by local repositories)
      final dataWithBusinessId = Map<String, dynamic>.from(value);
      if (!dataWithBusinessId.containsKey('business_id') && !dataWithBusinessId.containsKey('businessId')) {
        dataWithBusinessId['business_id'] = businessId;
      }
      
      // For table operations, pass businessId explicitly
      final upsertArgs = {
        'id': localId,
        'data': dataWithBusinessId,
      };
      if (resourceName == 'table') {
        upsertArgs['businessId'] = businessId;
      }
      
      await resource.local.execute('upsert', upsertArgs);
    }
  }
  
  /// Manual sync: Push local changes, then pull remote changes
  /// Full bidirectional sync
  /// Uses internal businessId
  Future<void> manualSync() async {
    // Step 1: Push local changes to server first
    await _queueService.processQueue();
    
    // Step 2: Pull remote changes to local
    for (final resource in _resources.all.values) {
      await _pull(resource.name, _businessId);
    }
  }
  
  /// Backup: Replace remote data with local data
  /// WARNING: Destructive operation - deletes all remote entities and recreates from local
  /// Uses internal businessId
  Future<void> backup() async {
    final businessId = _businessId;
    for (final resource in _resources.all.values) {
      // Get all local entities
      final localValues = await resource.local.execute('findMany', {
        'businessId': businessId,
      }) as List<Map<String, dynamic>>;
      
      for (final value in localValues) {
        final entityId = value['id'] as String;
        final serverId = value['serverId'] as String?;
        
        // Remove version from value (for clean create)
        final valueWithoutVersion = Map<String, dynamic>.from(value);
        valueWithoutVersion.remove('version');
        
        // If entity was synced before, delete it first
        if (serverId != null && serverId.isNotEmpty) {
          await _queueService.enqueue(
            resourceName: resource.name,
            action: 'delete',
            entityId: entityId,
            serverEntityId: serverId,
            entityData: {'business_id': businessId},
          );
        }
        
        // Enqueue create operation with local data
        await _queueService.enqueue(
          resourceName: resource.name,
          action: 'create',
          entityId: entityId,
          entityData: valueWithoutVersion,
        );
      }
    }
    
    // Process the queue to execute backup
    await _queueService.processQueue();
  }
  
  /// Get API client from a resource (for direct API calls when needed)
  /// Useful for operations not yet in repository pattern (e.g., categories)
  ApiClient? getApiClient(String resourceName) {
    final resource = _resources.get(resourceName);
    return resource?.remote.apiClient;
  }

  /// Restore: Replace local data with remote data
  /// WARNING: Destructive operation - deletes all local data and replaces with server data
  /// Uses internal businessId
  Future<void> restore() async {
    final businessId = _businessId;
    
    // Step 1: Delete all local entities (bulk delete by businessId)
    for (final resource in _resources.all.values) {
      print('Restore: Deleting all ${resource.name} records for businessId: $businessId');
      await resource.local.execute('deleteAll', {
        'businessId': businessId,
      });
      print('Restore: Deleted all ${resource.name} records');
    }
    
    // Step 2: Clear sync queue (all pending operations are invalid after restore)
    print('Restore: Clearing sync queue');
    await _localDb.clearSyncQueue();
    print('Restore: Sync queue cleared');
    
    // Step 3: Pull all data from remote (recreate locally)
    await manualSync();
  }
}
