import 'dart:convert';
import 'package:drift/drift.dart';
import 'local_repository.dart';
import '../database/app_database.dart';

/// Local repository for Product entities
class ProductLocalRepository extends LocalRepository {
  ProductLocalRepository(AppDatabase db) : super(db, 'product');
  
  @override
  Table get table => db.localProducts;
  
  /// Helper to parse timestamp (uses same logic as base class)
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
    // The entire data map (including version) is stored as JSON
    
    // Parse base_price safely - prioritize base_price from server, fallback to price for backward compatibility
    final basePriceValue = data['base_price'] ?? data['price'];
    final basePrice = basePriceValue != null 
        ? (basePriceValue is num ? basePriceValue.toDouble() : (double.tryParse(basePriceValue.toString()) ?? 0.0))
        : 0.0;
    
    await db.localProducts.insertOnConflictUpdate(
      LocalProductsCompanion(
        id: Value(id),
        serverId: Value(serverId),
        businessId: Value(businessId),
        name: Value(data['name'] as String? ?? ''),
        category: Value(data['category'] as String? ?? data['categoryId'] as String?),
        basePrice: Value(basePrice),
        data: Value(jsonEncode(data)), // Includes version if present
        isSynced: Value(serverId != null ? 1 : 0),
        createdAt: Value(createdAt),
        updatedAt: Value(updatedAt),
      ),
    );
  }
  
  @override
  Map<String, dynamic> _toMap(dynamic row) {
    if (row is LocalProduct) {
      try {
        final data = jsonDecode(row.data) as Map<String, dynamic>;
        // Ensure serverId is included (from table column)
        if (row.serverId != null) {
          data['serverId'] = row.serverId;
        }
        // Ensure local ID is included
        data['id'] = row.id;
        // Version is already in the JSON data if it came from server
        // No need to add it separately - it's preserved in the data field
        return data;
      } catch (e) {
        return <String, dynamic>{};
      }
    }
    return <String, dynamic>{};
  }
  
  @override
  Future<Map<String, dynamic>?> findOne(String id) async {
    final product = await (db.select(db.localProducts)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    
    if (product == null) return null;
    
    return _toMap(product);
  }
  
  @override
  Future<List<Map<String, dynamic>>> findMany(String businessId) async {
    final products = await (db.select(db.localProducts)
          ..where((tbl) => tbl.businessId.equals(businessId)))
        .get();
    
    return products.map((p) => _toMap(p)).where((p) => p.isNotEmpty).toList();
  }
  
  /// Get product by local ID (includes serverId and version)
  Future<Map<String, dynamic>?> getProductByLocalId(String localId) async {
    return await findOne(localId);
  }
}
