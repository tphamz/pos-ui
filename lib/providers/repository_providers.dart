import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/resources_registry.dart';
import '../database/database_providers.dart';
import '../providers/api_providers.dart';

/// Provider for ResourcesRegistry (singleton)
final resourcesRegistryProvider = Provider<ResourcesRegistry>((ref) {
  final registry = ResourcesRegistry();
  final db = ref.watch(appDatabaseProvider);
  final apiClient = ref.watch(apiClientProvider);
  final localDb = ref.watch(localDbServiceProvider);
  
  // Initialize resources on first access if not already initialized
  if (!registry.isInitialized) {
    registry.initialize(db: db, apiClient: apiClient, localDb: localDb);
  }
  
  return registry;
});
