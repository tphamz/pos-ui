# Test Coverage Summary

This document outlines the comprehensive test suite created for the POS Flutter application.

## Test Files Created

### 1. Unit Tests
- **`test/utils/validation_test.dart`** (13 tests)
  - Email validation
  - Phone number normalization and validation
  - Store code validation
  - Contact validation (email or phone)

### 2. Model Tests
- **`test/models/auth_models_test.dart`** (15 tests)
  - `RequestOTPRequest` serialization/deserialization
  - `VerifyOTPRequest` JSON mapping (snake_case)
  - `LoginRequest` serialization
  - `SignUpRequest` JSON mapping (snake_case)
  - `LoginResponse` deserialization with all fields
  - `SignUpResponse` deserialization
  - `BusinessRole` JSON mapping
  - `User` model deserialization
  - Null handling for optional fields

### 3. Service Tests
- **`test/services/auth_service_test.dart`** (10+ tests)
  - `requestOTP` - success and error cases
  - `verifyOTP` - success, invalid OTP, invalid response format
  - `login` - success and invalid credentials
  - `logout` - success and error handling

- **`test/services/user_service_test.dart`** (5+ tests)
  - `signup` - success with email only
  - `signup` - success with phone only
  - `signup` - success with both email and phone
  - `signup` - duplicate email error
  - `signup` - invalid response format

### 4. Provider Tests
- **`test/providers/auth_provider_test.dart`** (8+ tests)
  - Initial state verification
  - `requestOTP` state management
  - `verifyOTP` state management
  - `login` state management
  - `logout` state management
  - Error handling and state updates

- **`test/providers/theme_provider_test.dart`** (8+ tests)
  - ThemeNotifier initialization
  - `setTheme` method
  - `toggleTheme` method (cycles through light → dark → system → light)
  - Theme persistence
  - Theme mode state changes

### 5. Widget Tests
- **`test/screens/login_screen_test.dart`** (6+ tests)
  - Form field display
  - Validation errors for empty fields
  - Email format validation
  - Store code format validation
  - Password visibility toggle
  - Navigation to signup screen

- **`test/screens/signup_screen_test.dart`** (8+ tests)
  - Form field display
  - Required field validation
  - Email or phone requirement
  - Email format validation
  - Phone number format validation
  - Password match validation
  - Password visibility toggle
  - Successful form submission

- **`test/widgets/theme_toggle_button_test.dart`** (4+ tests)
  - Icon display for each theme mode (light, dark, system)
  - Theme toggle functionality
  - Button interaction

- **`test/widgets/global_app_bar_test.dart`** (6+ tests)
  - Title display
  - Back button visibility logic (hidden on home/login)
  - Logout button visibility (only when authenticated)
  - Theme toggle button presence
  - Route-based conditional rendering

## Test Dependencies

The following testing packages were added:
- `flutter_test` (built-in)
- `mockito` - For creating mocks
- `http_mock_adapter` - For mocking HTTP requests in Dio

## Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/utils/validation_test.dart

# Run with coverage
flutter test --coverage

# Run in watch mode (auto-rerun on changes)
flutter test --watch
```

## Test Coverage Areas

### ✅ Covered
- **Validation Logic**: All validation utilities
- **Model Serialization**: All auth models with JSON mapping
- **Service Layer**: Auth and User services with mocked HTTP calls
- **State Management**: Auth provider with Riverpod
- **UI Components**: Login and Signup screens with form validation

### 🔄 Can Be Extended
- Business service tests
- Product service tests
- Order service tests
- Home screen widget tests
- OTP verification screen tests
- Integration tests for complete user flows

## Notes

- Tests use `http_mock_adapter` to mock Dio HTTP requests
- Flutter bindings are initialized in `setUpAll` for tests that use SharedPreferences
- Widget tests use `ProviderScope` to provide Riverpod providers
- Some widget tests may need adjustments for async operations and navigation

## Test Statistics

- **Total Test Files**: 11
- **Total Tests**: 70+ individual test cases
- **Coverage**: Core authentication flow, validation, models, services, providers, widgets, and UI screens
