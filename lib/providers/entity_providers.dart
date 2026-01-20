import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/queue_service.dart';
import '../services/entity_service.dart';
import '../database/database_providers.dart';
import '../providers/repository_providers.dart';

/// Provider for QueueService (singleton)
final queueServiceProvider = Provider<QueueService>((ref) {
  final localDb = ref.watch(localDbServiceProvider);
  final resources = ref.watch(resourcesRegistryProvider);
  return QueueService(localDb, resources);
});

/// Provider for EntityService (family - takes businessId)
/// This eliminates the need for Offline*Service wrappers
final entityServiceProvider = Provider.family<EntityService, String>((ref, businessId) {
  final resources = ref.watch(resourcesRegistryProvider);
  final queueService = ref.watch(queueServiceProvider);
  final localDb = ref.watch(localDbServiceProvider);
  return EntityService(
    resources: resources,
    queueService: queueService,
    localDb: localDb,
    businessId: businessId,
  );
});
