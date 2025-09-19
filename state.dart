import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omspos/screen/home/api/home_api.dart';
import 'package:omspos/screen/home/model/home_model.dart';
import 'package:omspos/screen/home/model/property_model.dart';
import 'package:omspos/utils/custom_log.dart';

// State class (immutable)
class HomeState {
  final bool isLoading;
  final List<AreaModel> areas;
  final List<PropertyModel> properties;
  final String? errorMessage;

  const HomeState({
    this.isLoading = false,
    this.areas = const [],
    this.properties = const [],
    this.errorMessage,
  });

  // copyWith method for immutability
  HomeState copyWith({
    bool? isLoading,
    List<AreaModel>? areas,
    List<PropertyModel>? properties,
    String? errorMessage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      areas: areas ?? this.areas,
      properties: properties ?? this.properties,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// StateNotifier
class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(const HomeState());

  Future<void> initialize() async {
    await clean();
    await loadAllAreas();
    await loadProperties();
  }

  Future<void> clean() async {
    state = state.copyWith(
      isLoading: false,
      errorMessage: null,
      areas: [],
      properties: [],
    );
  }

  Future<void> loadAllAreas() async {
    if (state.isLoading) return;
    
    state = state.copyWith(isLoading: true);
    
    try {
      final areas = await HomeApi.getAllAreas();
      state = state.copyWith(
        areas: areas,
        errorMessage: null,
        isLoading: false,
      );
      CustomLog.successLog(value: 'Loaded ${areas.length} areas');
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
        areas: [],
        isLoading: false,
      );
      CustomLog.errorLog(value: 'Areas load error: ${e.toString()}');
    }
  }

  Future<void> loadProperties() async {
    if (state.isLoading) return;
    
    state = state.copyWith(isLoading: true);
    
    try {
      final properties = await HomeApi.getAllProperties();
      state = state.copyWith(
        properties: properties,
        errorMessage: null,
        isLoading: false,
      );
      CustomLog.successLog(value: 'Loaded ${properties.length} properties');
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
        properties: [],
        isLoading: false,
      );
      CustomLog.errorLog(value: 'Properties load error: ${e.toString()}');
    }
  }

  Future<void> refreshAreas() async {
    await loadAllAreas();
  }

  Future<void> refreshProperties() async {
    await loadProperties();
  }
}

// Riverpod Provider
final homeStateProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

// Optional: Separate providers for individual data if needed
final areasProvider = Provider<List<AreaModel>>((ref) {
  return ref.watch(homeStateProvider).areas;
});

final propertiesProvider = Provider<List<PropertyModel>>((ref) {
  return ref.watch(homeStateProvider).properties;
});

final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(homeStateProvider).isLoading;
});
