import 'dart:convert';
import 'package:drift/drift.dart';
import 'local_repository.dart';
import '../database/app_database.dart';
import '../database/local_db_service.dart';

/// Local repository for Table entities
/// Note: Tables are stored in business config, not as separate entities
/// This repository treats the entire tables list as a single entity
class TableLocalRepository extends LocalRepository {
  final LocalDbService _localDb;
  
  TableLocalRepository(AppDatabase db, LocalDbService localDb) 
      : _localDb = localDb,
        super(db, 'table');
  
  @override
  Table get table => throw UnimplementedError('Tables are stored in business config');
  
  /// Get all tables for a business
  /// Returns list of table maps
  @override
  Future<List<Map<String, dynamic>>> findMany(String businessId) async {
    return await _localDb.getTables(businessId);
  }
  
  /// Get a single table by ID
  /// Note: Tables don't have server IDs, they're identified by their 'id' or 'number' field
  @override
  Future<Map<String, dynamic>?> findOne(String id) async {
    // For tables, we need businessId to find the table
    // Since we don't have businessId in findOne, we'll need to search all businesses
    // This is a limitation - in practice, you'd pass businessId
    throw UnimplementedError('findOne requires businessId for tables - use findMany and filter');
  }
  
  /// Get a table by ID within a business
  Future<Map<String, dynamic>?> findOneInBusiness(String businessId, String tableId) async {
    final tables = await findMany(businessId);
    return tables.firstWhere(
      (t) => (t['id'] == tableId || t['number'] == tableId),
      orElse: () => <String, dynamic>{},
    );
  }
  
  /// Create a table (adds to tables list)
  @override
  Future<void> create(String id, Map<String, dynamic> data) async {
    // For tables, we need businessId
    final businessId = data['business_id'] as String? ?? data['businessId'] as String?;
    if (businessId == null) {
      throw Exception('business_id is required for table operations');
    }
    
    final tables = await findMany(businessId);
    tables.add(data);
    await upsert(businessId, {'tables': tables});
  }
  
  /// Update a table (updates in tables list)
  @override
  Future<void> update(String id, Map<String, dynamic> data) async {
    // For tables, we need businessId
    final businessId = data['business_id'] as String? ?? data['businessId'] as String?;
    if (businessId == null) {
      throw Exception('business_id is required for table operations');
    }
    
    final tables = await findMany(businessId);
    final index = tables.indexWhere(
      (t) => (t['id'] == id || t['number'] == id),
    );
    
    if (index != -1) {
      tables[index] = {...tables[index], ...data};
      await upsert(businessId, {'tables': tables});
    }
  }
  
  /// Delete a table (removes from tables list)
  @override
  Future<void> delete(String id) async {
    // For tables, we need businessId
    // Since we don't have it, this method signature is problematic
    // In practice, delete should be called with businessId
    throw UnimplementedError('delete requires businessId for tables - use deleteInBusiness');
  }
  
  /// Delete a table within a business
  Future<void> deleteInBusiness(String businessId, String tableId) async {
    final tables = await findMany(businessId);
    tables.removeWhere((t) => (t['id'] == tableId || t['number'] == tableId));
    await upsert(businessId, {'tables': tables});
  }
  
  /// Delete all tables for a business (clear tables array)
  @override
  Future<void> deleteAll(String businessId) async {
    await upsert(businessId, {'tables': <Map<String, dynamic>>[]});
  }
  
  /// Upsert tables list (saves entire tables list to business config)
  /// For tables, 'id' parameter is the businessId
  @override
  Future<void> upsert(String id, Map<String, dynamic> data) async {
    // For tables, 'id' is actually the businessId
    final businessId = id;
    final tables = data['tables'] as List<dynamic>?;
    
    if (tables == null) {
      throw Exception('tables array is required');
    }
    
    // Save to business config
    await _localDb.saveBusinessConfig(
      businessId: businessId,
      tablesData: {'tables': tables.cast<Map<String, dynamic>>()},
      settings: null,
      version: data['version'] as int?,
    );
  }
  
  /// Execute method override to handle table-specific operations
  @override
  Future<dynamic> execute(String action, Map<String, dynamic> args) {
    final businessId = args['businessId'] as String?;
    if (businessId == null) {
      throw Exception('businessId is required for table operations');
    }
    
    switch (action) {
      case 'findMany':
        return findMany(businessId);
      case 'findOne':
        final tableId = args['id'] as String;
        return findOneInBusiness(businessId, tableId);
      case 'create':
        final tableData = args['data'] as Map<String, dynamic>;
        tableData['business_id'] = businessId;
        return create(tableData['id'] as String? ?? tableData['number'] as String, tableData);
      case 'update':
        final tableId = args['id'] as String;
        final tableData = args['data'] as Map<String, dynamic>;
        tableData['business_id'] = businessId;
        return update(tableId, tableData);
      case 'delete':
        final tableId = args['id'] as String;
        return deleteInBusiness(businessId, tableId);
      case 'deleteAll':
        return deleteAll(businessId);
      case 'upsert':
        // For upsert, id is businessId
        return upsert(businessId, args['data'] as Map<String, dynamic>);
      default:
        throw Exception('Unknown action: $action for table');
    }
  }
}
