import '../services/entity_service.dart';
import '../providers/entity_providers.dart';

/// Service for initial data sync after login
/// Fetches products, staff, tickets, and tables from API and caches to local DB
/// Uses EntityService for all sync operations (new repository pattern)
class InitialSyncService {
  final EntityService _entityService;
  final String _businessId;

  InitialSyncService({
    required EntityService entityService,
    required String businessId,
  })  : _entityService = entityService,
        _businessId = businessId;

  /// Sync all initial data from API to local DB
  /// This should be called after successful login to populate local DB
  /// Pulls all resources (products, staff, tickets, tables) from server
  Future<void> syncInitialData() async {
    try {
      // Pull all resources from server using EntityService
      // EntityService already has businessId, so no need to pass it
      await _entityService.manualSync();
    } catch (e) {
      // Log error but don't throw - initial sync shouldn't block app usage
      // In production, you might want to log this to a monitoring service
      print('Error during initial sync: $e'); // ignore: avoid_print
    }
  }
}
