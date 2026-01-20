# POS Mobile App

Flutter mobile application for the POS (Point of Sale) system backend.

## Features

- **Authentication**: OTP-based and password-based login
- **Multi-tenant Support**: Support for multiple businesses
- **Offline-First Architecture**: Works seamlessly offline with automatic sync
- **Product Management**: View and manage products with categories and add-ons
- **Staff Management**: Manage staff members with role-based access
- **Table Management**: Manage tables for restaurant/salon businesses
- **Order/Ticket Management**: Create and manage orders/tickets
- **Modern UI**: Beautiful, responsive Material Design 3 interface
- **Repository Pattern**: Clean architecture with separation of concerns

## Setup

### Prerequisites

- Flutter SDK (3.10.7 or later)
- Dart SDK
- Backend API running (see main POS project README)

### Installation

1. **Install dependencies**:
   ```bash
   flutter pub get
   ```

2. **Generate code** (for Freezed models):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Configure API endpoint**:
   - Open `lib/config/api_config.dart`
   - Update `baseUrl` to match your backend API URL
   - Default: `http://localhost:8080` (for local development)

### Running the App

```bash
# Run on connected device/emulator
flutter run

# Run in release mode
flutter run --release

# Run on specific device
flutter run -d <device-id>
```

## Project Structure

```
lib/
├── config/              # Configuration (API endpoints, etc.)
├── database/            # Local database (Drift/SQLite)
│   ├── app_database.dart
│   └── local_db_service.dart
├── models/              # Data models (DTOs matching backend)
│   ├── auth_models.dart
│   ├── business_models.dart
│   ├── product_models.dart
│   ├── order_models.dart
│   └── pos/             # POS-specific models (Ticket, etc.)
├── repositories/        # Repository pattern implementation
│   ├── local_repository.dart      # Base class for local operations
│   ├── remote_repository.dart     # Base class for API operations
│   ├── resource.dart              # Resource wrapper (local + remote)
│   ├── resources_registry.dart    # Singleton registry for all resources
│   ├── product_local_repository.dart
│   ├── product_remote_repository.dart
│   ├── staff_local_repository.dart
│   ├── staff_remote_repository.dart
│   ├── ticket_local_repository.dart
│   ├── ticket_remote_repository.dart
│   ├── table_local_repository.dart
│   └── table_remote_repository.dart
├── services/           # Business logic services
│   ├── entity_service.dart       # Main orchestrator for entity operations
│   ├── queue_service.dart        # Sync queue management
│   ├── product_service.dart      # Typed product service
│   ├── table_service.dart        # Typed table service
│   ├── user_service.dart         # User/staff operations
│   ├── business_service.dart     # Business operations
│   ├── order_service.dart        # Order operations
│   ├── sync_manager.dart         # Automatic sync management
│   └── initial_sync_service.dart # Initial data sync
├── providers/          # Riverpod state management providers
│   ├── auth_provider.dart
│   ├── entity_providers.dart     # EntityService providers
│   ├── repository_providers.dart # Repository providers
│   └── api_providers.dart        # API service providers
├── screens/            # UI screens
├── widgets/            # Reusable UI widgets
│   └── pos/            # POS-specific widgets
└── utils/              # Utility functions
    ├── password_encryption.dart  # Password encryption for local storage
    └── validation.dart
```

## Architecture

### Repository Pattern

The app uses a **Repository Pattern** for clean separation between local and remote data operations:

- **LocalRepository**: Handles all local database operations (CRUD)
- **RemoteRepository**: Handles all API operations (CRUD)
- **Resource**: Combines a LocalRepository and RemoteRepository for each entity
- **ResourcesRegistry**: Singleton registry managing all resources
- **EntityService**: Main orchestrator providing high-level operations (`save`, `get`, `delete`, `pull`, `push`, `manualSync`)
- **QueueService**: Manages sync queue for offline operations

### Offline-First Design

- **Immediate Local Writes**: All operations save locally first
- **Background Sync**: Changes are queued and synced when online
- **Auto-Pull**: Automatically fetches from server if local data is empty
- **Optimistic Locking**: Version-based conflict resolution
- **Password Encryption**: Staff passwords encrypted locally before sync

### Key Technologies

- **State Management**: Riverpod
- **HTTP Client**: Dio
- **Local Database**: Drift (SQLite)
- **Code Generation**: Freezed for immutable models
- **Local Storage**: SharedPreferences for auth tokens and encryption keys
- **Encryption**: AES-256 for password encryption

## API Integration

The app integrates with the POS backend API. Make sure:

1. Backend is running and accessible
2. API base URL is correctly configured in `lib/config/api_config.dart`
3. CORS is properly configured on the backend (for web builds)

## Development

### Code Generation

After modifying models, regenerate code:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Or watch for changes:
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Testing

Run all tests:
```bash
flutter test
```

Run specific test files:
```bash
flutter test test/services/entity_service_test.dart
flutter test test/repositories/product_repository_e2e_test.dart
flutter test test/services/user_service_test.dart
```

Test coverage includes:
- EntityService operations (save, get, delete, sync)
- Repository pattern end-to-end tests
- User service (signup, assignBusinessRole)
- Table service operations
- Order service operations

See `docs/OFFLINE_TESTING_GUIDE.md` for manual testing procedures.

## Key Features

### Offline-First Operations

All entity operations (products, staff, tables, tickets) work offline:

```dart
// Get EntityService for a business
final entityService = ref.read(entityServiceProvider(businessId));

// Save product (saves locally, queues for sync)
await entityService.save(
  resourceName: 'product',
  id: 'product-123',
  data: {'name': 'Product Name', 'base_price': 10.99},
  isCreate: true,
);

// Get products (tries local first, auto-pulls if empty)
final products = await entityService.get('product');

// Delete product (deletes locally, queues for sync)
await entityService.delete('product', 'product-123');

// Manual sync (push local changes, then pull server changes)
await entityService.manualSync();
```

### Typed Services

For type safety, use typed services:

```dart
// ProductService (typed Product models)
final productService = ref.read(productServiceProvider(businessId));
final products = await productService.getProducts();
final product = await productService.getProduct('product-123');

// TableService (typed table operations)
final tableService = ref.read(tableServiceProvider(businessId));
final tables = await tableService.getTables();
```

### Sync Queue

The sync queue automatically processes pending operations:

- **Create**: Creates on server, updates local with serverId
- **Update**: Updates on server, merges server response
- **Delete**: Deletes on server, removes from local
- **Error Handling**: Retries up to 3 times, marks as failed after

## Documentation

- `docs/REPOSITORY_PATTERN_IMPLEMENTATION.md` - Repository pattern details
- `docs/OFFLINE_SYNC_FLOW.md` - Offline sync flow documentation
- `docs/OFFLINE_TESTING_GUIDE.md` - Manual testing guide
- `docs/CODE_QUALITY_COMPARISON.md` - Architecture comparison
- `docs/DESIGN_COMPARISON.md` - Design pattern comparison

## Notes

- The app uses Bearer token authentication
- Tokens are stored securely using SharedPreferences
- The app automatically adds `X-Client-Type: mobile` header to requests
- Staff passwords are encrypted locally (AES-256) and removed after successful sync
- All operations are offline-first - they work even without internet connection