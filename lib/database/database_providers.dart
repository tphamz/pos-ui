import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_database.dart';
import 'local_db_service.dart';

/// Provider for AppDatabase instance
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

/// Provider for LocalDbService instance
final localDbServiceProvider = Provider<LocalDbService>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return LocalDbService(db);
});
