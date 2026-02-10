import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failures.dart';
import '../../data/repository/home_repository_impl.dart';
import '../../domain/usecases/get_home_data_usecase.dart';
import 'home_state.dart';

/// Home State
export 'home_state.dart';

part 'home_notifier.g.dart';

/// Notifier for managing Home screen state
@riverpod
class HomeNotifier extends _$HomeNotifier {
  @override
  HomeState build() {
    return const HomeState.initial();
  }

  /// Loads all home data using the use case
  Future<void> loadHomeData() async {
    state = const HomeState.loading();

    final repository = HomeRepositoryImpl();
    final useCase = GetHomeDataUseCase(repository: repository);
    final result = await useCase().run();

    result.fold(
      (failure) => state = HomeState.error(message: _mapFailureToMessage(failure)),
      (data) => state = HomeState.loaded(
        categories: data.categories,
        recommendedFoods: data.recommendedFoods,
        fastDeliveryRestaurants: data.fastDeliveryRestaurants,
      ),
    );
  }

  /// Refreshes home data (pull-to-refresh)
  Future<void> refresh() async {
    await loadHomeData();
  }

  /// Maps failure to user-friendly error message
  String _mapFailureToMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return 'No internet connection. Please check your network.';
    } else if (failure is ServerFailure) {
      return 'Server error. Please try again later.';
    } else if (failure is AuthFailure) {
      return 'Authentication error. Please log in again.';
    } else if (failure is CacheFailure) {
      return 'Unable to load cached data.';
    }
    return 'Something went wrong. Please try again.';
  }
}
