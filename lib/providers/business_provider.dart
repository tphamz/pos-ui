import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/business_models.dart';
import '../services/business_service.dart';
import '../providers/api_providers.dart';
import '../database/database_providers.dart';

// Business List State
class BusinessListState {
  final List<Business> businesses;
  final bool isLoading;
  final String? error;

  BusinessListState({
    this.businesses = const [],
    this.isLoading = false,
    this.error,
  });

  BusinessListState copyWith({
    List<Business>? businesses,
    bool? isLoading,
    String? error,
  }) {
    return BusinessListState(
      businesses: businesses ?? this.businesses,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Business List Notifier
class BusinessListNotifier extends StateNotifier<BusinessListState> {
  final BusinessService _businessService;

  BusinessListNotifier(this._businessService) : super(BusinessListState());

  Future<void> loadBusinesses() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final businesses = await _businessService.getBusinesses();
      state = state.copyWith(
        businesses: businesses,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<Business> createBusiness(CreateBusinessRequest request) async {
    try {
      final business = await _businessService.createBusiness(request);
      state = state.copyWith(
        businesses: [...state.businesses, business],
      );
      return business;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }
}

// Business List Provider
final businessListProvider =
    StateNotifierProvider<BusinessListNotifier, BusinessListState>((ref) {
  final businessService = ref.watch(businessServiceProvider);
  return BusinessListNotifier(businessService);
});

// Individual Business Provider (returns BusinessDetailResponse with blueprint)
// Offline-first: Checks local DB first, then API if not found or stale
final businessProvider = FutureProvider.family<BusinessDetailResponse, String>((ref, id) async {
  final businessService = ref.watch(businessServiceProvider);
  final localDbService = ref.watch(localDbServiceProvider);
  
  // Try to get from local DB first
  final cachedBusiness = await localDbService.getBusinessDetail(id);
  
  // Check if cached data is stale (older than 1 hour)
  final isStale = await localDbService.isBusinessStale(id, staleHours: 1);
  
  if (cachedBusiness != null && !isStale) {
    // Return cached data if it exists and is fresh
    return cachedBusiness;
  }
  
  // Fetch from API if not cached or stale
  try {
    final businessDetail = await businessService.getBusiness(id);
    
    // Save to local DB for future offline use
    await localDbService.saveBusinessDetail(businessDetail);
    
    return businessDetail;
  } catch (e) {
    // If API call fails, return cached data if available (offline fallback)
    if (cachedBusiness != null) {
      return cachedBusiness;
    }
    // Re-throw if no cached data available
    rethrow;
  }
});
