import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_models.dart';
import '../providers/api_providers.dart';
import '../services/api_client.dart';
import '../services/auth_service.dart';
import '../database/database_providers.dart';
import '../services/initial_sync_service.dart';
import 'entity_providers.dart';

// Auth State
class AuthState {
  final LoginResponse? user;
  final bool isLoading;
  final String? error;

  AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    LoginResponse? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  bool get isAuthenticated => user != null;
  
  /// Get current business ID from user (for staff) or first business (for admin)
  String? get currentBusinessId {
    if (user == null) return null;
    // For staff type, use businessId directly
    if (user!.userType == 'staff' && user!.businessId != null) {
      return user!.businessId;
    }
    // For admin type, use first business if available
    if (user!.userType == 'admin' && user!.businesses != null && user!.businesses!.isNotEmpty) {
      return user!.businesses!.first.businessId;
    }
    return null;
  }
}

// Auth Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;
  final ApiClient _apiClient;
  final Ref? _ref; // For accessing providers during login

  AuthNotifier(this._authService, this._apiClient, {Ref? ref}) 
      : _ref = ref,
        super(AuthState()) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final token = await _apiClient.getAuthToken();
    if (token != null && token.isNotEmpty) {
      // Token exists, but we don't have user info
      // In a real app, you might want to fetch user info here
      // For now, we'll just mark as authenticated
    }
  }

  Future<String> requestOTP(String contact, {String? storeCode}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _authService.requestOTP(
        RequestOTPRequest(contact: contact, storeCode: storeCode),
      );
      state = state.copyWith(isLoading: false);
      return response.otpToken;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> verifyOTP(String otpToken, String otpCode) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _authService.verifyOTP(
        VerifyOTPRequest(otpToken: otpToken, otpCode: otpCode),
      );
      state = state.copyWith(
        user: response,
        isLoading: false,
        error: null,
      );
      
      // Cache business data after successful OTP verification
      await _cacheBusinessData(response);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> login(String contact, String password, {String? storeCode}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _authService.login(
        LoginRequest(contact: contact, password: password, storeCode: storeCode),
      );
      state = state.copyWith(
        user: response,
        isLoading: false,
        error: null,
      );
      
      // Cache business data after successful login
      await _cacheBusinessData(response);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> loginTerminal(String phone, String storeCode, String pin) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _authService.loginTerminal(
        LoginTerminalRequest(phone: phone, storeCode: storeCode, pin: pin),
      );
      state = state.copyWith(
        user: response,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _authService.logout();
      state = AuthState();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Cache business data after successful authentication
  Future<void> _cacheBusinessData(LoginResponse response) async {
    // Only cache if we have a business ID and ref is available
    if (_ref == null) return;
    
    final businessId = response.businessId;
    if (businessId == null) return; // Admin users might not have a single business
    
    try {
      final businessService = _ref!.read(businessServiceProvider);
      final localDbService = _ref!.read(localDbServiceProvider);
      
      // Fetch business detail (includes blueprint)
      final businessDetail = await businessService.getBusiness(businessId);
      
      // Save to local DB
      await localDbService.saveBusinessDetail(businessDetail);

      // Trigger initial data sync (products) in background
      // Don't await - let it happen asynchronously so it doesn't block login
      _syncInitialData(businessId).catchError((e) {
        // Silently fail - initial sync is best effort
        // ignore: avoid_print
      });
    } catch (e) {
      // Silently fail - caching is best effort, shouldn't block login
      // Log error in production if needed
    }
  }

  /// Sync initial data (products) from API to local DB
  /// This is called in background after business data is cached
  Future<void> _syncInitialData(String businessId) async {
    if (_ref == null) return;

    try {
      final entityService = _ref!.read(entityServiceProvider(businessId));

      final initialSyncService = InitialSyncService(
        entityService: entityService,
        businessId: businessId,
      );

      await initialSyncService.syncInitialData();
    } catch (e) {
      // Silently fail - initial sync shouldn't block app usage
      // ignore: avoid_print
    }
  }
}

// Auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  final apiClient = ref.watch(apiClientProvider);
  return AuthNotifier(authService, apiClient, ref: ref);
});
