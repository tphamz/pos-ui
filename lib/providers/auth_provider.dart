import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_models.dart';
import '../providers/api_providers.dart';
import '../services/api_client.dart';
import '../services/auth_service.dart';

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
}

// Auth Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;
  final ApiClient _apiClient;

  AuthNotifier(this._authService, this._apiClient) : super(AuthState()) {
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
}

// Auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  final apiClient = ref.watch(apiClientProvider);
  return AuthNotifier(authService, apiClient);
});
