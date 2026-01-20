import '../services/entity_service.dart';

/// Service for Table operations
/// Delegates to EntityService internally for actual operations
/// Provides offline-first table management with automatic sync
class TableService {
  final EntityService _entityService;
  final String _businessId;

  TableService(EntityService entityService, String businessId)
      : _entityService = entityService,
        _businessId = businessId;

  // Get all tables for a business
  // Offline-first: pulls from local first, then remote if local is empty
  Future<List<Map<String, dynamic>>> getTables() async {
    return await _entityService.get('table');
  }

  // Get a single table by ID
  // Offline-first: pulls from local first, then remote if not found locally
  Future<Map<String, dynamic>?> getTable(String tableId) async {
    return await _entityService.getOne('table', tableId);
  }

  // Create a table
  // Offline-first: saves locally, queues for sync to server
  Future<Map<String, dynamic>> createTable(Map<String, dynamic> tableData) async {
    // Generate local ID if not provided
    final tableId = tableData['id'] as String? ?? 
                    tableData['number'] as String? ?? 
                    DateTime.now().millisecondsSinceEpoch.toString();
    
    // Ensure businessId is in data
    final dataWithBusinessId = {
      ...tableData,
      'id': tableId,
      'business_id': _businessId,
    };
    
    // Save via EntityService (saves locally and queues for sync)
    return await _entityService.save(
      resourceName: 'table',
      id: tableId,
      data: dataWithBusinessId,
      isCreate: true,
    );
  }

  // Update a table
  // Offline-first: saves locally, queues for sync to server
  Future<Map<String, dynamic>> updateTable(
    String tableId,
    Map<String, dynamic> tableData,
  ) async {
    // Ensure businessId is in data
    final dataWithBusinessId = {
      ...tableData,
      'business_id': _businessId,
    };
    
    // Save via EntityService (saves locally and queues for sync)
    return await _entityService.save(
      resourceName: 'table',
      id: tableId,
      data: dataWithBusinessId,
      isCreate: false,
    );
  }

  // Delete a table
  // Offline-first: deletes locally, queues for sync to server
  Future<void> deleteTable(String tableId) async {
    // Delete via EntityService (deletes locally and queues for sync)
    await _entityService.delete('table', tableId);
  }
}
