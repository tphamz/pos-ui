import 'dart:convert';
import 'package:drift/drift.dart';
import 'local_repository.dart';
import '../database/app_database.dart';

/// Local repository for Ticket/Order entities
class TicketLocalRepository extends LocalRepository {
  TicketLocalRepository(AppDatabase db) : super(db, 'ticket');
  
  @override
  Table get table => db.localTickets;
  
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
    
    // Handle createdAt - can be ISO string, DateTime, or int
    int? createdAtMs;
    final createdAtValue = data['createdAt'] ?? data['created_at'];
    if (createdAtValue is String) {
      try {
        createdAtMs = DateTime.parse(createdAtValue).millisecondsSinceEpoch;
      } catch (e) {
        createdAtMs = now;
      }
    } else if (createdAtValue is int) {
      createdAtMs = createdAtValue;
    } else if (createdAtValue is DateTime) {
      createdAtMs = createdAtValue.millisecondsSinceEpoch;
    } else {
      createdAtMs = now;
    }
    
    final updatedAt = _parseTimestamp(data['updatedAt'] ?? data['updated_at']) ?? now;
    final serverId = data['serverId'] as String?;
    final businessIdValue = data['business_id'] as String? ?? data['businessId'] as String?;
    if (businessIdValue == null) {
      throw Exception('business_id is required');
    }
    final businessId = businessIdValue;
    
    // Preserve version if present (comes from server for optimistic locking)
    
    await db.localTickets.insertOnConflictUpdate(
      LocalTicketsCompanion(
        id: Value(id),
        serverId: Value(serverId),
        businessId: Value(businessId),
        orderNumber: Value(data['orderNumber'] as String? ?? data['order_number'] as String?),
        data: Value(jsonEncode(data)), // Includes version if present
        isSynced: Value(serverId != null ? 1 : 0),
        createdAt: Value(createdAtMs),
        updatedAt: Value(updatedAt),
      ),
    );
  }
  
  @override
  Map<String, dynamic> _toMap(dynamic row) {
    if (row is LocalTicket) {
      try {
        final data = jsonDecode(row.data) as Map<String, dynamic>;
        // Ensure serverId is included (from table column)
        if (row.serverId != null) {
          data['serverId'] = row.serverId;
        }
        // Ensure local ID is included
        data['id'] = row.id;
        // Version is already in the JSON data if it came from server
        return data;
      } catch (e) {
        return <String, dynamic>{};
      }
    }
    return <String, dynamic>{};
  }
  
  @override
  Future<Map<String, dynamic>?> findOne(String id) async {
    final ticket = await (db.select(db.localTickets)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    
    if (ticket == null) return null;
    
    return _toMap(ticket);
  }
  
  @override
  Future<List<Map<String, dynamic>>> findMany(String businessId) async {
    final tickets = await (db.select(db.localTickets)
          ..where((tbl) => tbl.businessId.equals(businessId)))
        .get();
    
    return tickets.map((t) => _toMap(t)).where((t) => t.isNotEmpty).toList();
  }
  
  @override
  Future<void> delete(String id) async {
    await (db.delete(db.localTickets)..where((tbl) => tbl.id.equals(id))).go();
  }
  
  /// Get ticket by local ID (includes serverId and version)
  Future<Map<String, dynamic>?> getTicketByLocalId(String localId) async {
    return await findOne(localId);
  }
}
