import 'dart:convert';
import 'package:drift/drift.dart';
import 'app_database.dart';
import '../models/business_models.dart';
import '../models/blueprint_models.dart';
import '../models/product_models.dart';

/// Service for local database operations
class LocalDbService {
  final AppDatabase _db;

  LocalDbService(this._db);

  // ============================================================================
  // Business Operations
  // ============================================================================

  /// Save business detail (with blueprint) to local DB
  Future<void> saveBusinessDetail(BusinessDetailResponse businessDetail) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    
    // Save business
    await _db.localBusinesses.insertOnConflictUpdate(
      LocalBusinessesCompanion(
        id: Value(businessDetail.id),
        name: Value(businessDetail.name),
        storeCode: Value(businessDetail.storeCode),
        blueprintId: Value(businessDetail.blueprintId),
        blueprintData: Value(businessDetail.blueprint != null 
            ? jsonEncode(businessDetail.blueprint!.toJson()) 
            : null),
        syncedAt: Value(now),
        createdAt: Value(businessDetail.createdAt?.millisecondsSinceEpoch ?? now),
      ),
    );
  }

  /// Get business detail from local DB
  Future<BusinessDetailResponse?> getBusinessDetail(String businessId) async {
    final business = await (_db.select(_db.localBusinesses)
          ..where((tbl) => tbl.id.equals(businessId)))
        .getSingleOrNull();

    if (business == null) return null;

    // Parse blueprint from JSON
    Blueprint? blueprint;
    if (business.blueprintData != null) {
      try {
        final blueprintJson = jsonDecode(business.blueprintData!) as Map<String, dynamic>;
        blueprint = Blueprint.fromJson(blueprintJson);
      } catch (e) {
        // If parsing fails, blueprint remains null
      }
    }

    return BusinessDetailResponse(
      id: business.id,
      name: business.name,
      storeCode: business.storeCode,
      blueprintId: business.blueprintId,
      createdAt: DateTime.fromMillisecondsSinceEpoch(business.createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(business.syncedAt),
      blueprint: blueprint,
    );
  }

  /// Check if business data is stale (older than specified hours)
  Future<bool> isBusinessStale(String businessId, {int staleHours = 1}) async {
    final business = await (_db.select(_db.localBusinesses)
          ..where((tbl) => tbl.id.equals(businessId)))
        .getSingleOrNull();

    if (business == null) return true;

    final age = DateTime.now().millisecondsSinceEpoch - business.syncedAt;
    final staleThreshold = staleHours * 60 * 60 * 1000; // Convert hours to milliseconds
    
    return age > staleThreshold;
  }

  // ============================================================================
  // Business Config Operations
  // ============================================================================

  /// Save business config (tables, settings) to local DB
  Future<void> saveBusinessConfig({
    required String businessId,
    Map<String, dynamic>? tablesData,
    Map<String, dynamic>? settings,
    int? version,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    await _db.localBusinessConfigs.insertOnConflictUpdate(
      LocalBusinessConfigsCompanion(
        businessId: Value(businessId),
        tablesData: Value(tablesData != null ? jsonEncode(tablesData) : null),
        settings: Value(settings != null ? jsonEncode(settings) : null),
        version: version != null ? Value(version) : const Value.absent(),
        lastSyncedAt: Value(now),
      ),
    );
  }

  /// Get business config from local DB
  Future<Map<String, dynamic>?> getBusinessConfig(String businessId) async {
    final config = await (_db.select(_db.localBusinessConfigs)
          ..where((tbl) => tbl.businessId.equals(businessId)))
        .getSingleOrNull();

    if (config == null) return null;

    final result = <String, dynamic>{};
    if (config.tablesData != null) {
      try {
        result['tables'] = jsonDecode(config.tablesData!);
      } catch (e) {
        // Ignore parse errors
      }
    }
    if (config.settings != null) {
      try {
        result['settings'] = jsonDecode(config.settings!);
      } catch (e) {
        // Ignore parse errors
      }
    }
    // Include version
    result['version'] = config.version;

    return result.isEmpty ? null : result;
  }

  /// Get business config version from local DB
  Future<int?> getBusinessConfigVersion(String businessId) async {
    final config = await (_db.select(_db.localBusinessConfigs)
          ..where((tbl) => tbl.businessId.equals(businessId)))
        .getSingleOrNull();

    return config?.version;
  }

  /// Get tables data from config
  Future<List<Map<String, dynamic>>> getTables(String businessId) async {
    final config = await getBusinessConfig(businessId);
    if (config == null) return [];
    
    // Handle both 'tables' array directly and nested in 'tablesData'
    var tables = config['tables'];
    if (tables == null && config.containsKey('tablesData')) {
      final tablesData = config['tablesData'];
      if (tablesData is Map && tablesData.containsKey('tables')) {
        tables = tablesData['tables'];
      }
    }
    
    if (tables == null) return [];
    
    if (tables is List) {
      return tables.cast<Map<String, dynamic>>();
    }
    return [];
  }

  // ============================================================================
  // Product Operations
  // ============================================================================

  /// Helper to convert timestamp (DateTime, String ISO8601, or int milliseconds) to milliseconds
  int? _parseTimestamp(dynamic timestamp) {
    if (timestamp == null) return null;
    if (timestamp is int) return timestamp;
    if (timestamp is DateTime) return timestamp.millisecondsSinceEpoch;
    if (timestamp is String) {
      try {
        return DateTime.parse(timestamp).millisecondsSinceEpoch;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Save product to local DB
  Future<void> saveProduct({
    required String id,
    String? serverId,
    required String businessId,
    required Map<String, dynamic> productData,
    bool isSynced = false,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    final createdAt = _parseTimestamp(productData['created_at']) ?? now;
    final updatedAt = _parseTimestamp(productData['updated_at']) ?? now;

    // Parse base_price safely - prioritize base_price from server, fallback to price for backward compatibility
    final basePriceValue = productData['base_price'] ?? productData['price'];
    final basePrice = basePriceValue != null 
        ? (basePriceValue is num ? basePriceValue.toDouble() : (double.tryParse(basePriceValue.toString()) ?? 0.0))
        : 0.0;
    
    await _db.localProducts.insertOnConflictUpdate(
      LocalProductsCompanion(
        id: Value(id),
        serverId: Value(serverId),
        businessId: Value(businessId),
        name: Value(productData['name'] as String? ?? ''),
        category: Value(productData['category'] as String?),
        basePrice: Value(basePrice),
        data: Value(jsonEncode(productData)),
        isSynced: Value(isSynced ? 1 : 0),
        createdAt: Value(createdAt),
        updatedAt: Value(updatedAt),
      ),
    );
  }

  /// Get products from local DB
  Future<List<Map<String, dynamic>>> getProducts(String businessId) async {
    final products = await (_db.select(_db.localProducts)
          ..where((tbl) => tbl.businessId.equals(businessId)))
        .get();

    return products.map((p) {
      try {
        return jsonDecode(p.data) as Map<String, dynamic>;
      } catch (e) {
        return <String, dynamic>{}; // Return empty map if parsing fails
      }
    }).where((p) => p.isNotEmpty).toList();
  }

  /// Get server ID for a product by local ID
  Future<String?> getProductServerId(String localId) async {
    final product = await (_db.select(_db.localProducts)
          ..where((tbl) => tbl.id.equals(localId)))
        .getSingleOrNull();
    return product?.serverId;
  }

  /// Get product data by local ID (for sync - includes version)
  Future<Map<String, dynamic>?> getProductByLocalId(String localId) async {
    final product = await (_db.select(_db.localProducts)
          ..where((tbl) => tbl.id.equals(localId)))
        .getSingleOrNull();
    
    if (product == null) return null;
    
    try {
      final data = jsonDecode(product.data) as Map<String, dynamic>;
      // Ensure serverId and version are included
      if (product.serverId != null) {
        data['serverId'] = product.serverId;
      }
      return data;
    } catch (e) {
      return null;
    }
  }

  /// Delete product from local DB
  Future<void> deleteProduct(String id) async {
    await (_db.delete(_db.localProducts)..where((tbl) => tbl.id.equals(id))).go();
  }

  // ============================================================================
  // Staff Operations
  // ============================================================================

  /// Save staff to local DB
  Future<void> saveStaff({
    required String id,
    String? serverId,
    required String businessId,
    required Map<String, dynamic> staffData,
    bool isSynced = false,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    // Extract full_name - matches server response field name
    final fullName = staffData['full_name'] as String? ?? 
                     staffData['name'] as String? ?? 
                     '';

    await _db.localStaff.insertOnConflictUpdate(
      LocalStaffCompanion(
        id: Value(id),
        serverId: Value(serverId),
        businessId: Value(businessId),
        fullName: Value(fullName),
        role: Value(staffData['role'] as String?),
        data: Value(jsonEncode(staffData)),
        isSynced: Value(isSynced ? 1 : 0),
        createdAt: Value(_parseTimestamp(staffData['created_at']) ?? now),
        updatedAt: Value(_parseTimestamp(staffData['updated_at']) ?? now),
      ),
    );
  }

  /// Get staff from local DB
  Future<List<Map<String, dynamic>>> getStaff(String businessId) async {
    final staffList = await (_db.select(_db.localStaff)
          ..where((tbl) => tbl.businessId.equals(businessId)))
        .get();

    return staffList.map((s) {
      try {
        return jsonDecode(s.data) as Map<String, dynamic>;
      } catch (e) {
        return <String, dynamic>{};
      }
    }).where((s) => s.isNotEmpty).toList();
  }

  /// Get server ID for staff by local ID
  Future<String?> getStaffServerId(String localId) async {
    final staff = await (_db.select(_db.localStaff)
          ..where((tbl) => tbl.id.equals(localId)))
        .getSingleOrNull();
    return staff?.serverId;
  }

  /// Delete staff from local DB
  Future<void> deleteStaff(String id) async {
    await (_db.delete(_db.localStaff)..where((tbl) => tbl.id.equals(id))).go();
  }

  // ============================================================================
  // Ticket Operations
  // ============================================================================

  /// Save ticket to local DB
  Future<void> saveTicket({
    required String id,
    String? serverId,
    required String businessId,
    required Map<String, dynamic> ticketData,
    bool isSynced = false,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    
    // Handle createdAt - can be ISO string or DateTime
    int? createdAtMs;
    final createdAtValue = ticketData['createdAt'];
    if (createdAtValue is String) {
      try {
        createdAtMs = DateTime.parse(createdAtValue).millisecondsSinceEpoch;
      } catch (e) {
        createdAtMs = now;
      }
    } else if (createdAtValue is int) {
      createdAtMs = createdAtValue;
    } else {
      createdAtMs = now;
    }

    await _db.localTickets.insertOnConflictUpdate(
      LocalTicketsCompanion(
        id: Value(id),
        serverId: Value(serverId),
        businessId: Value(businessId),
        orderNumber: Value(ticketData['orderNumber'] as String?),
        data: Value(jsonEncode(ticketData)),
        isSynced: Value(isSynced ? 1 : 0),
        createdAt: Value(createdAtMs),
        updatedAt: Value(now),
      ),
    );
  }

  /// Get tickets from local DB
  Future<List<Map<String, dynamic>>> getTickets(String businessId) async {
    final tickets = await (_db.select(_db.localTickets)
          ..where((tbl) => tbl.businessId.equals(businessId)))
        .get();

    return tickets.map((t) {
      try {
        return jsonDecode(t.data) as Map<String, dynamic>;
      } catch (e) {
        return <String, dynamic>{}; // Return empty map if parsing fails
      }
    }).where((t) => t.isNotEmpty).toList();
  }

  /// Get server ID for a ticket by local ID
  Future<String?> getTicketServerId(String localId) async {
    final ticket = await (_db.select(_db.localTickets)
          ..where((tbl) => tbl.id.equals(localId)))
        .getSingleOrNull();
    return ticket?.serverId;
  }

  /// Get ticket data by local ID (for sync - includes version)
  Future<Map<String, dynamic>?> getTicketByLocalId(String localId) async {
    final ticket = await (_db.select(_db.localTickets)
          ..where((tbl) => tbl.id.equals(localId)))
        .getSingleOrNull();
    
    if (ticket == null) return null;
    
    try {
      final data = jsonDecode(ticket.data) as Map<String, dynamic>;
      // Ensure serverId and version are included
      if (ticket.serverId != null) {
        data['serverId'] = ticket.serverId;
      }
      return data;
    } catch (e) {
      return null;
    }
  }

  /// Delete ticket from local DB
  Future<void> deleteTicket(String id) async {
    await (_db.delete(_db.localTickets)..where((tbl) => tbl.id.equals(id))).go();
  }

  // ============================================================================
  // Sync Queue Operations
  // ============================================================================

  /// Add item to sync queue
  /// Consolidates operations:
  /// - CREATE → DELETE: Remove CREATE entries, don't add DELETE (server never had it)
  /// - UPDATE → DELETE: Remove UPDATE entries, add DELETE (resource exists on server)
  /// - UPDATE → UPDATE: Remove previous UPDATE entries, keep only latest (optimization)
  /// - DELETE without serverEntityId: Remove all entries with same entityId (entity never synced)
  Future<int> addToSyncQueue({
    required String operationType, // 'create', 'update', 'delete'
    required String entityType, // 'product', 'staff', 'ticket', 'table'
    required String entityId,
    String? serverEntityId, // Server entity ID (for delete operations)
    Map<String, dynamic>? entityData,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    // Get all pending and syncing items for the same entity (for consolidation checks)
    final allPending = await getPendingSyncItems(limit: 1000);
    final allSyncing = await (_db.select(_db.syncQueue)
          ..where((tbl) => tbl.status.equals('syncing')))
        .get();
    
    final allRelevant = [...allPending, ...allSyncing]
        .where((item) => 
          item.entityType == entityType &&
          item.entityId == entityId &&
          (item.status == 'pending' || item.status == 'syncing')
        )
        .toList();

    // Consolidation: When UPDATE is added, merge previous UPDATE entries into the new one
    // This ensures we don't lose any field changes (e.g., name change + price change)
    Map<String, dynamic>? finalEntityData = entityData;
    if (operationType == 'update') {
      final pendingUpdates = allRelevant.where((item) => item.operationType == 'update').toList();
      if (pendingUpdates.isNotEmpty) {
        // Merge all previous UPDATE data into the new entityData
        // This ensures we preserve all field changes from previous UPDATEs
        Map<String, dynamic> mergedData = finalEntityData ?? {};
        
        for (final item in pendingUpdates) {
          if (item.entityData != null) {
            try {
              final previousData = jsonDecode(item.entityData!) as Map<String, dynamic>;
              // Merge previous data into current (current takes precedence for conflicts)
              mergedData = {...previousData, ...mergedData};
            } catch (e) {
              // If JSON decode fails, skip this item
              continue;
            }
          }
          // Remove the previous UPDATE entry
          await (_db.delete(_db.syncQueue)..where((tbl) => tbl.id.equals(item.id))).go();
        }
        
        // Use merged data for the new UPDATE
        finalEntityData = mergedData;
      }
    }

    // Consolidation: When DELETE is added
    if (operationType == 'delete') {
       for (final item in allRelevant) {
          await (_db.delete(_db.syncQueue)..where((tbl) => tbl.id.equals(item.id))).go();
        }
      if (serverEntityId == null || serverEntityId.isEmpty) {
        return 0;
      }
    }

    // Add the new operation to the queue (use merged data if UPDATE was consolidated)
    final id = await _db.into(_db.syncQueue).insert(
      SyncQueueCompanion.insert(
        operationType: operationType,
        entityType: entityType,
        entityId: entityId,
        serverEntityId: Value(serverEntityId),
        entityData: Value(finalEntityData != null ? jsonEncode(finalEntityData) : null),
        status: const Value('pending'),
        retryCount: const Value(0),
        createdAt: now,
      ),
    );

    return id;
  }

  /// Get pending sync queue items
  Future<List<SyncQueueData>> getPendingSyncItems({int limit = 50}) async {
    return await (_db.select(_db.syncQueue)
          ..where((tbl) => tbl.status.equals('pending'))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt)])
          ..limit(limit))
        .get();
  }

  /// Get failed sync queue items
  Future<List<SyncQueueData>> getFailedSyncItems({int limit = 50}) async {
    return await (_db.select(_db.syncQueue)
          ..where((tbl) => tbl.status.equals('failed'))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt)])
          ..limit(limit))
        .get();
  }

  /// Update sync queue item status
  Future<void> updateSyncQueueStatus(
    int queueId, {
    required String status,
    int? retryCount,
    String? errorMessage,
  }) async {
    await (_db.update(_db.syncQueue)
          ..where((tbl) => tbl.id.equals(queueId)))
        .write(
      SyncQueueCompanion(
        status: Value(status),
        retryCount: Value(retryCount ?? 0),
        errorMessage: Value(errorMessage),
        updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  /// Remove item from sync queue
  Future<void> removeFromSyncQueue(int queueId) async {
    await (_db.delete(_db.syncQueue)..where((tbl) => tbl.id.equals(queueId))).go();
  }

  /// Clear all sync queue items (bulk delete)
  Future<void> clearSyncQueue() async {
    await (_db.delete(_db.syncQueue)).go();
  }

  /// Get sync queue item by ID
  Future<SyncQueueData?> getSyncQueueItem(int queueId) async {
    return await (_db.select(_db.syncQueue)
          ..where((tbl) => tbl.id.equals(queueId)))
        .getSingleOrNull();
  }

  /// Check if an entity has pending sync operations
  Future<bool> hasPendingSyncForEntity(String entityType, String entityId) async {
    final pendingItems = await (_db.select(_db.syncQueue)
          ..where((tbl) => 
            tbl.entityType.equals(entityType) &
            tbl.entityId.equals(entityId) &
            (tbl.status.equals('pending') | tbl.status.equals('syncing'))
          ))
        .get();
    return pendingItems.isNotEmpty;
  }

  /// Get all sync queue items (for debugging)
  Future<List<SyncQueueData>> getAllSyncQueueItems({int limit = 100}) async {
    return await (_db.select(_db.syncQueue)
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)])
          ..limit(limit))
        .get();
  }

  /// Get sync queue items by status
  Future<List<SyncQueueData>> getSyncQueueItemsByStatus(String status, {int limit = 100}) async {
    return await (_db.select(_db.syncQueue)
          ..where((tbl) => tbl.status.equals(status))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)])
          ..limit(limit))
        .get();
  }
}
