part of 'splash_screen.dart';

/// Sealed class for splash navigation events
sealed class SplashNavigationEvent {
  const SplashNavigationEvent();

  const factory SplashNavigationEvent.toOnboarding() = _ToOnboarding;
  const factory SplashNavigationEvent.toSignIn() = _ToSignIn;
  const factory SplashNavigationEvent.toLocationPermission() = _ToLocationPermission;
  const factory SplashNavigationEvent.toDietaryPreferences() = _ToDietaryPreferences;
  const factory SplashNavigationEvent.toHome() = _ToHome;
}

class _ToOnboarding extends SplashNavigationEvent {
  const _ToOnboarding();
}

class _ToSignIn extends SplashNavigationEvent {
  const _ToSignIn();
}

class _ToLocationPermission extends SplashNavigationEvent {
  const _ToLocationPermission();
}

class _ToDietaryPreferences extends SplashNavigationEvent {
  const _ToDietaryPreferences();
}

class _ToHome extends SplashNavigationEvent {
  const _ToHome();
}

/// Splash screen state
@immutable
class SplashState {
  const SplashState({
    this.isLoading = true,
    this.errorMessage = null,
    this.navigationEvent = null,
  });

  final bool isLoading;
  final String? errorMessage;
  final SplashNavigationEvent? navigationEvent;

  SplashState copyWith({
    bool? isLoading,
    String? errorMessage,
    SplashNavigationEvent? navigationEvent,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      navigationEvent: navigationEvent ?? this.navigationEvent,
    );
  }

  /// Check if loading
  bool get isNotLoading => !isLoading;

  /// Check if has error
  bool get hasError => errorMessage != null;

  /// Check if has navigation
  bool get hasNavigation => navigationEvent != null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SplashState &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage &&
        other.navigationEvent == navigationEvent;
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      errorMessage.hashCode ^
      navigationEvent.hashCode;
}
