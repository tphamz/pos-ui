import 'local_repository.dart';
import 'remote_repository.dart';

/// Optional transformer for entity-specific data transformations
abstract class EntityTransformer {
  /// Transform data before saving locally
  Map<String, dynamic> transformForLocal(Map<String, dynamic> data);
  
  /// Transform data before sending to remote
  Map<String, dynamic> transformForRemote(Map<String, dynamic> data);
}

/// Optional validator for entity-specific validation
abstract class EntityValidator {
  /// Validate data before saving
  bool validate(Map<String, dynamic> data);
  
  /// Get validation error message
  String? getErrorMessage(Map<String, dynamic> data);
}

/// Resource wrapper that combines local and remote repositories for an entity
class Resource {
  final String name;
  final LocalRepository local;
  final RemoteRepository remote;
  final EntityTransformer? transformer;
  final EntityValidator? validator;
  
  Resource({
    required this.name,
    required this.local,
    required this.remote,
    this.transformer,
    this.validator,
  });
}
