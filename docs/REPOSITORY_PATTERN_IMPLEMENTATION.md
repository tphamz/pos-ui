# Repository Pattern Implementation

Complete implementation of the Repository Pattern for offline-first data management in the POS mobile app.

## ✅ Implementation Status

### Core Infrastructure
- ✅ `LocalRepository` - Abstract base class for local DB operations
- ✅ `RemoteRepository` - Abstract base class for API operations
- ✅ `Resource` - Wrapper combining local + remote repositories
- ✅ `ResourcesRegistry` - Singleton registry for all resources
- ✅ `EntityService` - Main orchestrator for entity operations
- ✅ `QueueService` - Sync queue management

### Entity Implementations

#### Product
- ✅ `ProductLocalRepository` - Handles local product storage
- ✅ `ProductRemoteRepository` - Handles API calls for products
- ✅ `ProductService` - Typed service wrapper (optional, for type safety)
- ✅ Registered in `ResourcesRegistry` as `'product'`

#### Staff
- ✅ `StaffLocalRepository` - Handles local staff storage
- ✅ `StaffRemoteRepository` - Handles API calls for staff
- ✅ Password encryption (AES-256) for local storage
- ✅ Password removal after successful sync
- ✅ Registered in `ResourcesRegistry` as `'staff'`

#### Ticket/Order
- ✅ `TicketLocalRepository` - Handles local ticket storage
- ✅ `TicketRemoteRepository` - Handles API calls for tickets/orders
- ✅ Registered in `ResourcesRegistry` as `'ticket'`
- ✅ Note: Tickets and Orders are the same entity (tickets = draft orders)

#### Table
- ✅ `TableLocalRepository` - Handles local table storage (in business config)
- ✅ `TableRemoteRepository` - Handles API calls for tables
- ✅ `TableService` - Typed service wrapper (optional, for type safety)
- ✅ Special handling: Tables stored in business config, not as separate entities
- ✅ Registered in `ResourcesRegistry` as `'table'`

### Services

#### Core Services
- ✅ `EntityService` - Main orchestrator (takes `businessId` in constructor)
  - `save()` - Create or update entity (offline-first)
  - `get()` - Get all entities (offline-first with auto-pull)
  - `getOne()` - Get single entity (offline-first with auto-pull)
  - `delete()` - Delete entity (offline-first)
  - `pull()` - Pull from server to local
  - `manualSync()` - Push local changes, then pull server changes
  - `backup()` - Replace remote data with local data
  - `restore()` - Replace local data with remote data

- ✅ `QueueService` - Processes sync queue
  - `enqueue()` - Add operation to sync queue
  - `processQueue()` - Process pending operations
  - Handles create, update, delete operations
  - Retry logic (up to 3 attempts)
  - Error handling and status tracking

#### Typed Services (Optional)
- ✅ `ProductService` - Typed wrapper around EntityService for products
- ✅ `TableService` - Typed wrapper around EntityService for tables
- ✅ `OrderService` - Read operations for orders (uses EntityService internally)

#### Supporting Services
- ✅ `SyncManager` - Automatic sync based on connectivity
- ✅ `InitialSyncService` - Initial data sync after login
- ✅ `UserService` - User operations (signup, assignBusinessRole with offline-first)

### Providers

- ✅ `resourcesRegistryProvider` - Singleton registry provider
- ✅ `queueServiceProvider` - Queue service provider
- ✅ `entityServiceProvider` - Entity service provider (family - takes `businessId`)
- ✅ `productServiceProvider` - Product service provider (family - takes `businessId`)
- ✅ `tableServiceProvider` - Table service provider (family - takes `businessId`)
- ✅ `orderServiceProvider` - Order service provider

## 🧪 Testing Status

### Automated Tests

#### EntityService Tests (`test/services/entity_service_test.dart`)
- ✅ Test 1: Save (create) - saves locally and queues for sync
- ✅ Test 2: Save (update) - updates locally and queues for sync
- ✅ Test 3: Delete - deletes locally and queues for sync
- ✅ Test 4: Get with auto-pull - pulls from server if local is empty
- ✅ Test 5: GetOne with auto-pull - pulls from server if not found locally
- ✅ Test 6: Auto-pull error handling - gracefully handles network errors
- ✅ Test 7: Manual sync - pushes local changes then pulls server changes
- ✅ Test 8: Local data priority - local data takes precedence over server

#### Product Repository E2E Tests (`test/repositories/product_repository_e2e_test.dart`)
- ✅ Test 1: Create product - saves locally and queues for sync
- ✅ Test 2: Update product - merges changes and queues update
- ✅ Test 3: Delete product - removes locally and queues delete
- ✅ Test 4: Sync create operation - creates on server and updates local
- ✅ Test 5: Pull products from server - updates local database
- ✅ Test 6: Full sync - push local changes then pull server changes

#### User Service Tests (`test/services/user_service_test.dart`)
- ✅ Test 1-5: Signup tests (various scenarios)
- ✅ Test 6-7: assignBusinessRole - offline-first with password encryption
- ✅ Test 8-9: getUsersByBusinessId - offline-first with auto-pull

#### Table Service Tests (`test/services/table_service_test.dart`)
- ✅ Test 1: Get tables - returns empty list initially
- ✅ Test 2: Create table - saves locally and queues for sync
- ✅ Test 3: Get table by ID - returns table from local
- ✅ Test 4: Update table - saves locally and queues for sync
- ✅ Test 5: Delete table - deletes locally and queues for sync
- ✅ Test 6: Auto-pull - pulls from server if local is empty

#### Order Service Tests (`test/services/order_service_test.dart`)
- ✅ Test 1: Get orders - returns from local first (offline-first)
- ✅ Test 2: Get orders with status filter - filters by status
- ✅ Test 3: Get order by ID - returns from local first
- ✅ Test 4: Auto-pull - pulls from server if local is empty

**Total: 30+ tests passing** ✅

## 📋 Usage Examples

### Basic Entity Operations

```dart
// Get EntityService for a business
final entityService = ref.read(entityServiceProvider(businessId));

// Create product (saves locally, queues for sync)
await entityService.save(
  resourceName: 'product',
  id: 'product-123',
  data: {
    'name': 'Test Product',
    'base_price': 10.99,
    'tax_rate': 0.1,
    'category': 'Food',
  },
  isCreate: true,
);

// Update product
await entityService.save(
  resourceName: 'product',
  id: 'product-123',
  data: {
    'name': 'Updated Product',
    'base_price': 15.99,
  },
  isCreate: false,
);

// Get all products (tries local first, auto-pulls if empty)
final products = await entityService.get('product');

// Get single product (tries local first, auto-pulls if not found)
final product = await entityService.getOne('product', 'product-123');

// Delete product (deletes locally, queues for sync)
await entityService.delete('product', 'product-123');

// Manual sync (push local changes, then pull server changes)
await entityService.manualSync();
```

### Typed Services (Recommended)

```dart
// ProductService (typed Product models)
final productService = ref.read(productServiceProvider(businessId));
final products = await productService.getProducts();
final product = await productService.getProduct('product-123');
await productService.createProduct(CreateProductRequest(...));
await productService.updateProduct('product-123', UpdateProductRequest(...));
await productService.deleteProduct('product-123');

// TableService (typed table operations)
final tableService = ref.read(tableServiceProvider(businessId));
final tables = await tableService.getTables();
final table = await tableService.getTable('table-1');
await tableService.createTable({'number': '1', 'name': 'Table 1'});
await tableService.updateTable('table-1', {'name': 'Updated Table 1'});
await tableService.deleteTable('table-1');

// OrderService (read operations)
final orderService = ref.read(orderServiceProvider);
final orders = await orderService.getOrders(businessId, entityService);
final completedOrders = await orderService.getOrders(
  businessId, 
  entityService, 
  status: 'completed',
);
final order = await orderService.getOrder(businessId, 'order-123', entityService);
```

### Staff Operations (with Password Encryption)

```dart
final userService = ref.read(userServiceProvider);
final entityService = ref.read(entityServiceProvider(businessId));

// Assign business role (offline-first, password encrypted locally)
final userRole = await userService.assignBusinessRole(
  businessId,
  AssignBusinessRoleRequest(
    fullName: 'John Staff',
    email: 'staff@example.com',
    phoneNumber: '+1234567890',
    role: 'server',
    password: 'password123', // Will be encrypted locally
  ),
  entityService,
);

// Get users by business ID (offline-first with auto-pull)
final users = await userService.getUsersByBusinessId(businessId, entityService);
```

### Sync Operations

```dart
// Process sync queue manually
final queueService = ref.read(queueServiceProvider);
await queueService.processQueue();

// Full sync (push then pull)
final entityService = ref.read(entityServiceProvider(businessId));
await entityService.manualSync();

// Pull specific resource from server
await entityService.pull('product');

// Backup: Replace remote data with local data (destructive!)
await entityService.backup();

// Restore: Replace local data with remote data (destructive!)
await entityService.restore();
```

## 🔍 Debugging

### Check Sync Queue

```dart
final localDb = ref.read(localDbServiceProvider);
final queueItems = await localDb.getPendingSyncItems();
print('Pending items: ${queueItems.length}');
for (final item in queueItems) {
  print('${item.operationType} ${item.entityType} (${item.entityId}) - Status: ${item.status}');
}
```

### Check Resources Registry

```dart
final resources = ref.read(resourcesRegistryProvider);
print('Registered resources: ${resources.all.keys}');
print('Product resource exists: ${resources.has('product')}');
print('Staff resource exists: ${resources.has('staff')}');
print('Ticket resource exists: ${resources.has('ticket')}');
print('Table resource exists: ${resources.has('table')}');
```

### Check Local Data

```dart
final entityService = ref.read(entityServiceProvider(businessId));

// Check products
final products = await entityService.get('product');
print('Local products: ${products.length}');
for (final product in products) {
  print('${product['name']} - serverId: ${product['serverId']}');
}

// Check staff
final staff = await entityService.get('staff');
print('Local staff: ${staff.length}');

// Check tables
final tables = await entityService.get('table');
print('Local tables: ${tables.length}');
```

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────┐
│      ResourcesRegistry (Singleton)       │
│  - Central registry for all resources   │
│  - Shared by EntityService & QueueService│
│  - Initialized once at app startup      │
└─────────────────────────────────────────┘
              ↑ shared by
    ┌─────────┴─────────┐
    ↓                   ↓
┌─────────────────┐  ┌─────────────────┐
│ EntityService    │  │ QueueService     │
│ - save/get/delete│  │ - enqueue        │
│ - pull/push      │  │ - processQueue   │
│ - manualSync     │  │ - error handling │
│ - backup/restore │  └─────────────────┘
└─────────────────┘
    ↓ uses
┌─────────────────────────────────────────┐
│         Resource (per entity)            │
│  - LocalRepository (DB operations)       │
│  - RemoteRepository (API operations)    │
└─────────────────────────────────────────┘
```

## 🎯 Key Features

### Offline-First Design
- **Immediate Local Writes**: All operations save locally first
- **Background Sync**: Changes are queued and synced when online
- **Auto-Pull**: Automatically fetches from server if local data is empty
- **Optimistic Locking**: Version-based conflict resolution
- **Password Encryption**: Staff passwords encrypted locally (AES-256) before sync

### Special Cases

#### Tables
- Tables are stored in `business_config.industry_data.tables` (not as separate entities)
- `TableLocalRepository` handles the business config structure
- Requires `businessId` for all operations
- No server IDs (tables identified by `id` or `number` field)

#### Tickets/Orders
- Tickets and Orders are the same entity
- Tickets = draft orders
- Completed tickets become orders
- `TicketRemoteRepository` calls `/businesses/{id}/orders` endpoints

#### Staff Passwords
- Passwords encrypted locally using AES-256 before saving
- Flagged with `_password_encrypted: true`
- Decrypted before sending to server
- Removed from local storage after successful sync

## ✅ Benefits Realized

✅ **Clean separation** - Local vs Remote clearly separated  
✅ **Testable** - Each repository can be mocked independently  
✅ **Scalable** - Easy to add new entities (just add repositories)  
✅ **Maintainable** - Single responsibility per class  
✅ **Type-safe** - Strong typing throughout  
✅ **Offline-first** - Works seamlessly without internet  
✅ **Consistent** - Same pattern for all entities  
✅ **Production-ready** - Error handling, retry logic, encryption  

## 📝 Notes

- `EntityService` takes `businessId` in constructor for convenience
- Typed services (`ProductService`, `TableService`) are optional wrappers
- All operations are offline-first - they work even without internet
- Sync happens automatically in the background when online
- Manual sync available via `entityService.manualSync()`
- Password encryption keys stored securely in SharedPreferences

## 🔗 Related Documentation

- `docs/OFFLINE_TESTING_GUIDE.md` - Manual testing procedures
- `README.md` - Project overview and setup
