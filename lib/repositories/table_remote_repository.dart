import 'package:dio/dio.dart';
import 'remote_repository.dart';
import '../services/api_client.dart';
import '../models/business_models.dart';

/// Remote repository for Table entities
/// Note: Tables are stored in business config, not as separate entities
/// This repository updates business config to sync tables
class TableRemoteRepository extends RemoteRepository {
  TableRemoteRepository(ApiClient apiClient) 
      : super(apiClient, 'table', '/businesses/{id}/config');
  
  /// Get all tables for a business (from config)
  @override
  Future<List<Map<String, dynamic>>> findMany(String businessId) async {
    try {
      final response = await apiClient.dio.get(
        '/businesses/$businessId/config',
      );
      final config = BusinessConfig.fromJson(response.data as Map<String, dynamic>);
      
      // Extract tables from industryData
      final industryData = config.industryData ?? {};
      final tables = industryData['tables'] as List<dynamic>?;
      
      if (tables == null) return [];
      
      return tables.cast<Map<String, dynamic>>();
    } catch (e) {
      rethrow;
    }
  }
  
  /// Get a single table by ID (not really applicable for tables in config)
  @override
  Future<Map<String, dynamic>?> findOne(String businessId, String id) async {
    final tables = await findMany(businessId);
    try {
      return tables.firstWhere(
        (t) => (t['id'] == id || t['number'] == id),
      );
    } catch (e) {
      return null;
    }
  }
  
  /// Create a table (updates business config with new table)
  @override
  Future<Map<String, dynamic>> create(String businessId, Map<String, dynamic> data) async {
    // Get current config
    final currentConfig = await apiClient.dio.get(
      '/businesses/$businessId/config',
    );
    final config = BusinessConfig.fromJson(currentConfig.data as Map<String, dynamic>);
    
    // Get existing tables
    final industryData = Map<String, dynamic>.from(config.industryData ?? {});
    final tables = List<Map<String, dynamic>>.from(
      (industryData['tables'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [],
    );
    
    // Add new table
    tables.add(data);
    industryData['tables'] = tables;
    
    // Update config
    final updateRequest = UpdateBusinessConfigRequest(
      industryData: industryData,
      version: config.version,
    );
    
    final response = await apiClient.dio.put(
      '/businesses/$businessId/config',
      data: updateRequest.toJson(),
    );
    
    final updatedConfig = BusinessConfig.fromJson(response.data as Map<String, dynamic>);
    final updatedTables = (updatedConfig.industryData?['tables'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];
    
    // Return the newly created table
    return updatedTables.last;
  }
  
  /// Update a table (updates business config)
  @override
  Future<Map<String, dynamic>> update(String businessId, String id, Map<String, dynamic> data) async {
    // Get current config
    final currentConfig = await apiClient.dio.get(
      '/businesses/$businessId/config',
    );
    final config = BusinessConfig.fromJson(currentConfig.data as Map<String, dynamic>);
    
    // Get existing tables
    final industryData = Map<String, dynamic>.from(config.industryData ?? {});
    final tables = List<Map<String, dynamic>>.from(
      (industryData['tables'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [],
    );
    
    // Find and update table
    final index = tables.indexWhere(
      (t) => (t['id'] == id || t['number'] == id),
    );
    
    if (index == -1) {
      throw Exception('Table not found: $id');
    }
    
    // Merge update data
    tables[index] = {...tables[index], ...data};
    industryData['tables'] = tables;
    
    // Update config with version for optimistic locking
    final updateRequest = UpdateBusinessConfigRequest(
      industryData: industryData,
      version: data['version'] as int? ?? config.version,
    );
    
    final response = await apiClient.dio.put(
      '/businesses/$businessId/config',
      data: updateRequest.toJson(),
    );
    
    final updatedConfig = BusinessConfig.fromJson(response.data as Map<String, dynamic>);
    final updatedTables = (updatedConfig.industryData?['tables'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];
    
    // Return the updated table
    return updatedTables[index];
  }
  
  /// Delete a table (updates business config)
  @override
  Future<void> delete(String businessId, String id) async {
    // Get current config
    final currentConfig = await apiClient.dio.get(
      '/businesses/$businessId/config',
    );
    final config = BusinessConfig.fromJson(currentConfig.data as Map<String, dynamic>);
    
    // Get existing tables
    final industryData = Map<String, dynamic>.from(config.industryData ?? {});
    final tables = List<Map<String, dynamic>>.from(
      (industryData['tables'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [],
    );
    
    // Remove table
    tables.removeWhere((t) => (t['id'] == id || t['number'] == id));
    industryData['tables'] = tables;
    
    // Update config
    final updateRequest = UpdateBusinessConfigRequest(
      industryData: industryData,
      version: config.version,
    );
    
    await apiClient.dio.put(
      '/businesses/$businessId/config',
      data: updateRequest.toJson(),
    );
  }
  
  /// Execute method override to handle table-specific operations
  @override
  Future<dynamic> execute(String action, Map<String, dynamic> args) {
    final businessId = args['businessId'] as String;
    
    switch (action) {
      case 'findMany':
        return findMany(businessId);
      case 'findOne':
        return findOne(businessId, args['id'] as String);
      case 'create':
        return create(businessId, args['data'] as Map<String, dynamic>);
      case 'update':
        // For tables, update the entire tables list
        // The 'id' in args is the businessId, and data contains the tables array
        final tables = args['data']['tables'] as List<dynamic>?;
        if (tables == null) {
          throw Exception('tables array is required for update');
        }
        // Update entire tables list
        return _updateTablesList(businessId, tables.cast<Map<String, dynamic>>(), args['data']['version'] as int?);
      case 'delete':
        return delete(businessId, args['id'] as String);
      default:
        throw Exception('Unknown action: $action for table');
    }
  }
  
  /// Update entire tables list (used by sync)
  Future<void> _updateTablesList(String businessId, List<Map<String, dynamic>> tables, int? version) async {
    // Get current config
    final currentConfig = await apiClient.dio.get(
      '/businesses/$businessId/config',
    );
    final config = BusinessConfig.fromJson(currentConfig.data as Map<String, dynamic>);
    
    // Update industryData with new tables
    final industryData = Map<String, dynamic>.from(config.industryData ?? {});
    industryData['tables'] = tables;
    
    // Update config
    final updateRequest = UpdateBusinessConfigRequest(
      industryData: industryData,
      version: version ?? config.version,
    );
    
    await apiClient.dio.put(
      '/businesses/$businessId/config',
      data: updateRequest.toJson(),
    );
  }
}
