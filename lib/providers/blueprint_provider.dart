import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/blueprint_models.dart';
import 'business_provider.dart';
import 'auth_provider.dart';

/// Provider that gets the current business's blueprint
/// Returns null if no business is selected or blueprint is not loaded
final currentBlueprintProvider = Provider<Blueprint?>((ref) {
  final authState = ref.watch(authProvider);
  final currentBusinessId = authState.currentBusinessId;

  if (currentBusinessId == null) {
    return null;
  }

  final businessAsync = ref.watch(businessProvider(currentBusinessId));
  return businessAsync.when(
    data: (businessDetail) => businessDetail.blueprint,
    loading: () => null,
    error: (_, __) => null,
  );
});

/// Provider that gets label mappings from the current blueprint
/// Returns empty map if no blueprint is available
final labelMappingsProvider = Provider<Map<String, dynamic>>((ref) {
  final blueprint = ref.watch(currentBlueprintProvider);
  return blueprint?.labelMappings ?? {};
});

/// Provider that gets logic rules from the current blueprint
/// Returns empty map if no blueprint is available
final logicRulesProvider = Provider<Map<String, dynamic>>((ref) {
  final blueprint = ref.watch(currentBlueprintProvider);
  return blueprint?.logicRules ?? {};
});

/// Provider that gets UI schema from the current blueprint
/// Returns empty map if no blueprint is available
final uiSchemaProvider = Provider<Map<String, dynamic>>((ref) {
  final blueprint = ref.watch(currentBlueprintProvider);
  return blueprint?.uiSchema ?? {};
});
