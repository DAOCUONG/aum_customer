part of 'splash_screen.dart';

/// Splash screen notifier using Riverpod 3.0+
class SplashNotifier extends AutoDisposeNotifier<SplashState> {
  @override
  SplashState build() {
    return const SplashState();
  }

  /// Initialize splash screen - always navigate to onboarding
  Future<void> initialize() async {
    state = state.copyWith(isLoading: true);

    // Simulate a short delay for splash effect
    await Future.delayed(const Duration(seconds: 2));

    // Navigate to onboarding
    _navigateToOnboarding();
  }

  /// Navigate to onboarding screen
  void _navigateToOnboarding() {
    state = state.copyWith(
      isLoading: false,
      navigationEvent: const SplashNavigationEvent.toOnboarding(),
    );
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
