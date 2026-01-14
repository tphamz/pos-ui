# POS Mobile App

Flutter mobile application for the POS (Point of Sale) system backend.

## Features

- **Authentication**: OTP-based and password-based login
- **Multi-tenant Support**: Support for multiple businesses
- **Product Management**: View and manage products
- **Order Management**: Create and manage orders
- **Modern UI**: Beautiful, responsive Material Design 3 interface

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
├── config/          # Configuration (API endpoints, etc.)
├── models/          # Data models (DTOs matching backend)
├── services/        # API service classes
├── providers/       # Riverpod state management providers
├── screens/         # UI screens
├── widgets/         # Reusable UI widgets
└── utils/           # Utility functions (validation, etc.)
```

## Architecture

- **State Management**: Riverpod
- **HTTP Client**: Dio
- **Code Generation**: Freezed for immutable models
- **Local Storage**: SharedPreferences for auth tokens

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

```bash
flutter test
```

## Notes

- The app uses Bearer token authentication
- Tokens are stored securely using SharedPreferences
- The app automatically adds `X-Client-Type: mobile` header to requests
