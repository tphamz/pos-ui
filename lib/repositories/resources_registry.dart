import 'resource.dart';
import 'product_local_repository.dart';
import 'product_remote_repository.dart';
import 'staff_local_repository.dart';
import 'staff_remote_repository.dart';
import 'ticket_local_repository.dart';
import 'ticket_remote_repository.dart';
import 'table_local_repository.dart';
import 'table_remote_repository.dart';
import '../database/app_database.dart';
import '../database/local_db_service.dart';
import '../services/api_client.dart';

/// Singleton registry for all resources
/// Shared between EntityService and QueueService to ensure consistency
class ResourcesRegistry {
  static final ResourcesRegistry _instance = ResourcesRegistry._internal();
  factory ResourcesRegistry() => _instance;
  ResourcesRegistry._internal();
  
  final Map<String, Resource> _resources = {};
  bool _initialized = false;
  
  /// Register a resource
  void register(Resource resource) {
    _resources[resource.name] = resource;
  }
  
  /// Get a resource by name
  Resource? get(String name) {
    return _resources[name];
  }
  
  /// Get all resources
  Map<String, Resource> get all => Map.unmodifiable(_resources);
  
  /// Check if resource exists
  bool has(String name) {
    return _resources.containsKey(name);
  }
  
  /// Check if registry is initialized
  bool get isInitialized => _initialized;
  
  /// Clear all resources (for testing)
  void clear() {
    _resources.clear();
    _initialized = false;
  }
  
  /// Initialize all resources (called once at app startup)
  void initialize({
    required AppDatabase db,
    required ApiClient apiClient,
    required LocalDbService localDb,
  }) {
    if (_initialized) {
      return; // Already initialized
    }
    
    // Register Product resource
    _resources['product'] = Resource(
      name: 'product',
      local: ProductLocalRepository(db),
      remote: ProductRemoteRepository(apiClient),
    );
    
    // Register Staff resource
    _resources['staff'] = Resource(
      name: 'staff',
      local: StaffLocalRepository(db),
      remote: StaffRemoteRepository(apiClient),
    );
    
    // Register Ticket resource
    _resources['ticket'] = Resource(
      name: 'ticket',
      local: TicketLocalRepository(db),
      remote: TicketRemoteRepository(apiClient),
    );
    
    // Register Table resource (special - uses business config)
    _resources['table'] = Resource(
      name: 'table',
      local: TableLocalRepository(db, localDb),
      remote: TableRemoteRepository(apiClient),
    );
    
    _initialized = true;
  }
}
