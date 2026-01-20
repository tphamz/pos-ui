import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

/// Local Businesses table - cached from remote API
class LocalBusinesses extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get storeCode => text().nullable()();
  TextColumn get blueprintId => text().nullable()();
  TextColumn get blueprintData => text().nullable()(); // JSON: full blueprint cached
  IntColumn get syncedAt => integer()(); // timestamp in milliseconds
  IntColumn get createdAt => integer()(); // timestamp in milliseconds
  
  @override
  Set<Column> get primaryKey => {id};
}

/// Local Business Configs table - stores tables and other config
class LocalBusinessConfigs extends Table {
  TextColumn get businessId => text()();
  TextColumn get tablesData => text().nullable()(); // JSON array of tables
  TextColumn get settings => text().nullable()(); // JSON for other config
  IntColumn get version => integer().withDefault(const Constant(1))(); // Optimistic locking version
  IntColumn get lastSyncedAt => integer()(); // timestamp in milliseconds
  
  @override
  Set<Column> get primaryKey => {businessId};
}

/// Local Products table - cached and syncable
class LocalProducts extends Table {
  TextColumn get id => text()(); // Local ID (primary key, never changes)
  TextColumn get serverId => text().nullable()(); // Server ID (set after sync)
  TextColumn get businessId => text()();
  TextColumn get name => text()();
  TextColumn get category => text().nullable()();
  RealColumn get basePrice => real()(); // Renamed from price to base_price to match server
  TextColumn get data => text()(); // JSON: full product data
  IntColumn get isSynced => integer().withDefault(const Constant(0))(); // 0=pending, 1=synced
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  
  @override
  Set<Column> get primaryKey => {id};
}

/// Local Staff table - cached and syncable
class LocalStaff extends Table {
  TextColumn get id => text()(); // Local ID (primary key, never changes)
  TextColumn get serverId => text().nullable()(); // Server ID (set after sync)
  TextColumn get businessId => text()();
  TextColumn get fullName => text()(); // Matches server response field name
  TextColumn get role => text().nullable()();
  TextColumn get data => text()(); // JSON: full staff data
  IntColumn get isSynced => integer().withDefault(const Constant(0))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  
  @override
  Set<Column> get primaryKey => {id};
}

/// Local Tickets/Orders table - cached and syncable
class LocalTickets extends Table {
  TextColumn get id => text()(); // Local ID (primary key, never changes)
  TextColumn get serverId => text().nullable()(); // Server ID (set after sync)
  TextColumn get businessId => text()();
  TextColumn get orderNumber => text().nullable()();
  TextColumn get data => text()(); // JSON: full ticket data
  IntColumn get isSynced => integer().withDefault(const Constant(0))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  
  @override
  Set<Column> get primaryKey => {id};
}

/// Sync Queue table - tracks operations to sync to remote
class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get operationType => text()(); // 'create', 'update', 'delete'
  TextColumn get entityType => text()(); // 'product', 'staff', 'ticket', 'table'
  TextColumn get entityId => text()(); // Local entity ID
  TextColumn get serverEntityId => text().nullable()(); // Server entity ID (for delete operations)
  TextColumn get entityData => text().nullable()(); // JSON: data to sync
  TextColumn get status => text().withDefault(const Constant('pending'))(); // 'pending', 'syncing', 'synced', 'failed'
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get errorMessage => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer().nullable()();
}

@DriftDatabase(tables: [
  LocalBusinesses,
  LocalBusinessConfigs,
  LocalProducts,
  LocalStaff,
  LocalTickets,
  SyncQueue,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Migration 1->2: Add serverId columns to LocalProducts, LocalStaff, LocalTickets
      if (from < 2) {
        await m.addColumn(localProducts, localProducts.serverId);
        await m.addColumn(localStaff, localStaff.serverId);
        await m.addColumn(localTickets, localTickets.serverId);
      }
      // Migration 2->3: Add version column to LocalBusinessConfigs
      if (from < 3) {
        await m.addColumn(localBusinessConfigs, localBusinessConfigs.version);
      }
      // Migration 3->4: Add serverEntityId column to SyncQueue
      if (from < 4) {
        await m.addColumn(syncQueue, syncQueue.serverEntityId);
      }
      // Migration 4->5: Rename LocalStaff.name to full_name to match server response
      if (from < 5) {
        // SQLite supports RENAME COLUMN (since 3.25.0)
        await m.database.customStatement('ALTER TABLE local_staff RENAME COLUMN name TO full_name');
      }
      // Migration 5->6: Rename LocalProducts.price to base_price to match server response
      if (from < 6) {
        // Use table recreation approach for maximum compatibility
        // This works on all SQLite versions
        await m.database.customStatement('''
          CREATE TABLE IF NOT EXISTS local_products_new (
            id TEXT NOT NULL PRIMARY KEY,
            server_id TEXT,
            business_id TEXT NOT NULL,
            name TEXT NOT NULL,
            category TEXT,
            base_price REAL NOT NULL,
            data TEXT NOT NULL,
            is_synced INTEGER NOT NULL DEFAULT 0,
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL
          )
        ''');
        await m.database.customStatement('''
          INSERT INTO local_products_new 
          (id, server_id, business_id, name, category, base_price, data, is_synced, created_at, updated_at)
          SELECT id, server_id, business_id, name, category, price, data, is_synced, created_at, updated_at
          FROM local_products
        ''');
        await m.database.customStatement('DROP TABLE IF EXISTS local_products');
        await m.database.customStatement('ALTER TABLE local_products_new RENAME TO local_products');
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'pos_local.db'));
    return NativeDatabase(file);
  });
}
