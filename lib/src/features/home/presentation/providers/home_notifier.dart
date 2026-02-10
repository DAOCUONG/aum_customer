import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failures.dart';
import '../../data/repository/home_repository_provider.dart';
import '../../domain/repository/home_repository_interface.dart';
import '../../domain/usecases/get_home_data_usecase.dart';
import 'home_state.dart';

/// Home State
export 'home_state.dart';

part 'home_notifier.g.dart';

/// Notifier for managing Home screen state with proper dependency injection.
///
/// Responsibilities:
/// - Load home data on initialization
/// - Handle loading, success, and error states
/// - Provide refresh capability for pull-to-refresh
/// - Clean up resources on disposal
///
/// Dependencies are injected via Riverpod for testability.
@riverpod
class HomeNotifier extends _$HomeNotifier {
  HomeRepositoryInterface? _repository;
  GetHomeDataUseCase? _useCase;
  bool _isDisposed = false;

  @override
  HomeState build() {
    // Initialize dependencies via Riverpod container
    _repository = ref.read(homeRepositoryProvider);
    _useCase = GetHomeDataUseCase(repository: _repository!);

    // Register cleanup callback
    ref.onDispose(() {
      _isDisposed = true;
      _repository = null;
      _useCase = null;
    });

    // Load data immediately on build
    unawaited(_loadHomeData());
    return const HomeState.loading();
  }

  /// Loads all home data using the use case with proper error handling.
  ///
  /// Handles the following scenarios:
  /// - Network failures: Shows user-friendly network error message
  /// - Server errors: Shows server error message
  /// - Authentication errors: Shows auth error message
  /// - Unexpected errors: Shows generic error message with retry option
  Future<void> loadHomeData() async {
    await _loadHomeData();
  }

  /// Internal method to load home data with state guards.
  ///
  /// Prevents multiple concurrent loads and handles disposal race conditions.
  Future<void> _loadHomeData() async {
    if (_isDisposed) return;

    state = const HomeState.loading();

    final useCase = _useCase;
    if (useCase == null) {
      _setErrorState('Configuration error: Repository not initialized');
      return;
    }

    final result = await useCase().run();

    if (_isDisposed) return;

    result.fold(
      (failure) => _setErrorState(_mapFailureToMessage(failure)),
      (data) => _setLoadedState(data),
    );
  }

  /// Refreshes home data (pull-to-refresh).
  ///
  /// Simply delegates to [loadHomeData] for consistency.
  Future<void> refresh() async {
    await loadHomeData();
  }

  /// Sets the loaded state after validating data integrity.
  void _setLoadedState(HomeData data) {
    if (_isDisposed) return;

    // Determine if we should show empty state or loaded state
    final hasContent = data.categories.isNotEmpty ||
        data.recommendedFoods.isNotEmpty ||
        data.fastDeliveryRestaurants.isNotEmpty;

    if (!hasContent) {
      state = HomeState.empty(
        categories: data.categories,
        recommendedFoods: data.recommendedFoods,
        fastDeliveryRestaurants: data.fastDeliveryRestaurants,
      );
      return;
    }

    state = HomeState.loaded(
      categories: data.categories,
      recommendedFoods: data.recommendedFoods,
      fastDeliveryRestaurants: data.fastDeliveryRestaurants,
    );
  }

  /// Sets the error state with the given message.
  void _setErrorState(String message) {
    if (_isDisposed) return;
    state = HomeState.error(message: message);
  }

  /// Maps failure to user-friendly error message.
  ///
  /// Handles:
  /// - [NetworkFailure]: No internet connection
  /// - [ServerFailure]: Server-side errors
  /// - [AuthFailure]: Authentication issues
  /// - [CacheFailure]: Local cache errors
  /// - [UnexpectedFailure]: Any other error
  String _mapFailureToMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return 'No internet connection. Please check your network settings.';
    } else if (failure is ServerFailure) {
      return 'Server is temporarily unavailable. Please try again later.';
    } else if (failure is AuthFailure) {
      return 'Session expired. Please log in again.';
    } else if (failure is CacheFailure) {
      return 'Unable to load cached data. Please try again.';
    } else if (failure is UnexpectedFailure) {
      return 'Something went wrong. Please try again.';
    }
    return 'An unexpected error occurred. Please try again.';
  }
}
