import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/business_models.dart';
import '../providers/api_providers.dart';

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

// Individual Business Provider
final businessProvider = FutureProvider.family<Business, String>((ref, id) async {
  final businessService = ref.watch(businessServiceProvider);
  return businessService.getBusiness(id);
});
