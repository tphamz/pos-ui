import 'dart:convert';
import 'package:drift/drift.dart';
import 'local_repository.dart';
import '../database/app_database.dart';

/// Local repository for Staff entities
class StaffLocalRepository extends LocalRepository {
  StaffLocalRepository(AppDatabase db) : super(db, 'staff');
  
  @override
  Table get table => db.localStaff;
  
  /// Helper to parse timestamp
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
  
  @override
  Future<void> upsert(String id, Map<String, dynamic> data) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    
    final createdAt = _parseTimestamp(data['created_at']) ?? now;
    final updatedAt = _parseTimestamp(data['updated_at']) ?? now;
    final serverId = data['serverId'] as String?;
    final businessIdValue = data['business_id'] as String? ?? data['businessId'] as String?;
    if (businessIdValue == null) {
      throw Exception('business_id is required');
    }
    final businessId = businessIdValue;
    
    // Preserve version if present (comes from server for optimistic locking)
    // Version is stored in the JSON data field, not as a separate column
    
    // Extract full_name - matches server response field name
    final fullName = data['full_name'] as String? ?? 
                     data['name'] as String? ?? 
                     '';
    
    await db.localStaff.insertOnConflictUpdate(
      LocalStaffCompanion(
        id: Value(id),
        serverId: Value(serverId),
        businessId: Value(businessId),
        fullName: Value(fullName),
        role: Value(data['role'] as String?),
        data: Value(jsonEncode(data)), // Includes version if present
        isSynced: Value(serverId != null ? 1 : 0),
        createdAt: Value(createdAt),
        updatedAt: Value(updatedAt),
      ),
    );
  }
  
  @override
  Map<String, dynamic> _toMap(dynamic row) {
    // Note: Queries return LocalStaffData (the data class), not LocalStaff (the table class)
    // We use dynamic to avoid importing the generated file directly
    try {
      // Access fields dynamically to work with the data class
      final rowMap = row as dynamic;
      final dataString = rowMap.data as String;
      final data = jsonDecode(dataString) as Map<String, dynamic>;
      
      // Ensure serverId is included (from table column)
      final serverId = rowMap.serverId as String?;
      if (serverId != null) {
        data['serverId'] = serverId;
      }
      
      // Ensure local ID is included
      data['id'] = rowMap.id as String;
      
      // Ensure full_name and role are included from table columns if missing in JSON
      final fullName = rowMap.fullName as String?;
      if (fullName != null && fullName.isNotEmpty && !data.containsKey('full_name')) {
        data['full_name'] = fullName;
      }
      
      final role = rowMap.role as String?;
      if (role != null && role.isNotEmpty && !data.containsKey('role')) {
        data['role'] = role;
      }
      
      // Version is already in the JSON data if it came from server
      return data;
    } catch (e) {
      return <String, dynamic>{};
    }
  }
  
  @override
  Future<Map<String, dynamic>?> findOne(String id) async {
    final staff = await (db.select(db.localStaff)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    
    if (staff == null) return null;
    
    return _toMap(staff);
  }
  
  @override
  Future<List<Map<String, dynamic>>> findMany(String businessId) async {
    final staffList = await (db.select(db.localStaff)
          ..where((tbl) => tbl.businessId.equals(businessId)))
        .get();
    
    return staffList.map((s) => _toMap(s)).where((s) => s.isNotEmpty).toList();
  }
  
  @override
  Future<void> delete(String id) async {
    await (db.delete(db.localStaff)..where((tbl) => tbl.id.equals(id))).go();
  }
  
  /// Get staff by local ID (includes serverId and version)
  Future<Map<String, dynamic>?> getStaffByLocalId(String localId) async {
    return await findOne(localId);
  }
}
