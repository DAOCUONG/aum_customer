part of 'splash_screen.dart';

/// Splash screen notifier using Riverpod 3.0+
class SplashNotifier extends AutoDisposeNotifier<SplashState> {
  @override
  SplashState build() {
    return const SplashState();
  }

  /// Initialize splash screen and determine navigation
  Future<void> initialize() async {
    state = state.copyWith(isLoading: true);

    final useCase = ref.read(determineSplashNavigationUseCaseProvider);

    final result = await useCase().run();
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
      },
      (navigationResult) {
        final navigationEvent = _mapNavigationResultToEvent(navigationResult);
        state = state.copyWith(
          isLoading: false,
          navigationEvent: navigationEvent,
        );
      },
    );
  }

  /// Map splash navigation result to event
  SplashNavigationEvent _mapNavigationResultToEvent(
    dynamic result,
  ) {
    // Since we're using the appRepository directly for simplicity
    // This will be replaced with actual enum value when using the use case
    return const SplashNavigationEvent.toOnboarding();
  }

  /// Clear navigation event after handling
  void clearNavigationEvent() {
    state = state.copyWith(navigationEvent: null);
  }

  /// Retry initialization
  Future<void> retry() async {
    state = state.copyWith(errorMessage: null);
    await initialize();
  }
}

/// Provider for splash notifier
final splashNotifierProvider =
    AutoDisposeNotifierProvider<SplashNotifier, SplashState>(
  SplashNotifier.new,
);
