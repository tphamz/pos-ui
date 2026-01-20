import 'package:drift/drift.dart';
import '../database/app_database.dart';

/// Abstract base class for local database repositories
/// Provides generic CRUD operations for local storage
abstract class LocalRepository {
  final AppDatabase db;
  final String entityType;
  
  LocalRepository(this.db, this.entityType);
  
  /// Get the Drift table for this entity type
  /// Must be implemented by subclasses
  Table get table;
  
  /// Helper to parse timestamp (DateTime, String ISO8601, or int milliseconds) to milliseconds
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
  
  /// Find one entity by local ID
  Future<Map<String, dynamic>?> findOne(String id) async {
    // This is a generic implementation that works with any table
    // Subclasses can override if needed
    final query = db.select(table as dynamic)
      ..where((tbl) {
        // Get the 'id' column dynamically
        final idColumn = (table as dynamic).id;
        return idColumn.equals(id);
      });
    
    final result = await query.getSingleOrNull();
    if (result == null) return null;
    
    // Convert result to Map
    // This is table-specific, so subclasses should override
    return _toMap(result);
  }
  
  /// Find many entities by business ID
  Future<List<Map<String, dynamic>>> findMany(String businessId) async {
    final query = db.select(table as dynamic)
      ..where((tbl) {
        final businessIdColumn = (table as dynamic).businessId;
        return businessIdColumn.equals(businessId);
      });
    
    final results = await query.get();
    return results.map((r) => _toMap(r)).toList();
  }
  
  /// Create a new entity
  Future<void> create(String id, Map<String, dynamic> data) async {
    await upsert(id, data);
  }
  
  /// Update an existing entity
  Future<void> update(String id, Map<String, dynamic> data) async {
    await upsert(id, data);
  }
  
  /// Delete an entity by ID
  Future<void> delete(String id) async {
    await (db.delete(table as dynamic)..where((tbl) {
      final idColumn = (table as dynamic).id;
      return idColumn.equals(id);
    })).go();
  }
  
  /// Delete all entities for a businessId
  Future<void> deleteAll(String businessId) async {
    await (db.delete(table as dynamic)..where((tbl) {
      final businessIdColumn = (table as dynamic).businessId;
      return businessIdColumn.equals(businessId);
    })).go();
  }
  
  /// Upsert (insert or update) an entity
  /// Must be implemented by subclasses as table structure varies
  Future<void> upsert(String id, Map<String, dynamic> data);
  
  /// Convert table row to Map
  /// Must be implemented by subclasses
  Map<String, dynamic> _toMap(dynamic row);
  
  /// Get server ID for an entity by local ID
  Future<String?> getServerId(String localId) async {
    final entity = await findOne(localId);
    return entity?['serverId'] as String?;
  }
  
  /// Generic execute method for action-based operations
  Future<dynamic> execute(String action, Map<String, dynamic> args) {
    switch (action) {
      case 'findOne':
        return findOne(args['id'] as String);
      case 'findMany':
        return findMany(args['businessId'] as String);
      case 'create':
        return create(args['id'] as String, args['data'] as Map<String, dynamic>);
      case 'update':
        return update(args['id'] as String, args['data'] as Map<String, dynamic>);
      case 'delete':
        return delete(args['id'] as String);
      case 'deleteAll':
        return deleteAll(args['businessId'] as String);
      case 'upsert':
        return upsert(args['id'] as String, args['data'] as Map<String, dynamic>);
      default:
        throw Exception('Unknown action: $action');
    }
  }
}
