import 'package:equatable/equatable.dart';
import 'user_entity.dart';

/// Result of authentication operation
class AuthResult extends Equatable {
  const AuthResult({
    required this.success,
    this.user,
    this.token,
    this.refreshToken,
    this.errorCode,
    this.errorMessage,
  });

  final bool success;
  final UserEntity? user;
  final String? token;
  final String? refreshToken;
  final String? errorCode;
  final String? errorMessage;

  /// Successful authentication
  static AuthResult successWith({
    required UserEntity user,
    required String token,
    String? refreshToken,
  }) {
    return AuthResult(
      success: true,
      user: user,
      token: token,
      refreshToken: refreshToken,
    );
  }

  /// Failed authentication
  static AuthResult failure({
    required String errorCode,
    required String errorMessage,
  }) {
    return AuthResult(
      success: false,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        success,
        user,
        token,
        refreshToken,
        errorCode,
        errorMessage,
      ];

  /// Check if authentication was successful
  bool get isSuccess => success;

  /// Check if authentication failed
  bool get isFailure => !success;
}

/// Location permission status
enum LocationPermissionStatus {
  granted,
  denied,
  restricted,
  permanentlyDenied,
  notDetermined,
}

/// Location permission result
class LocationPermissionResult extends Equatable {
  const LocationPermissionResult({
    required this.status,
    this.isGranted = false,
    this.canAskAgain = true,
    this.errorMessage,
  });

  final LocationPermissionStatus status;
  final bool isGranted;
  final bool canAskAgain;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, isGranted, canAskAgain, errorMessage];

  /// Create from permission service status
  static LocationPermissionResult fromServiceStatus(
    dynamic permissionStatus,
  ) {
    // This would be implemented based on the actual permission package
    return const LocationPermissionResult(
      status: LocationPermissionStatus.notDetermined,
      isGranted: false,
      canAskAgain: true,
    );
  }
}

/// App initialization result
class InitializationResult extends Equatable {
  const InitializationResult({
    required this.isInitialized,
    this.isFirstLaunch = false,
    this.hasOnboardingCompleted = false,
    this.hasLocationPermission = false,
    this.hasDietaryPreferences = false,
    this.errorMessage,
  });

  final bool isInitialized;
  final bool isFirstLaunch;
  final bool hasOnboardingCompleted;
  final bool hasLocationPermission;
  final bool hasDietaryPreferences;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        isInitialized,
        isFirstLaunch,
        hasOnboardingCompleted,
        hasLocationPermission,
        hasDietaryPreferences,
        errorMessage,
      ];

  /// Check if app needs onboarding
  bool get needsOnboarding => !hasOnboardingCompleted;

  /// Check if app needs location permission
  bool get needsLocationPermission => !hasLocationPermission;

  /// Check if app needs dietary preferences
  bool get needsDietaryPreferences => !hasDietaryPreferences;

  /// Check if app is ready for home
  bool get isReadyForHome =>
      hasOnboardingCompleted &&
      hasLocationPermission &&
      hasDietaryPreferences;
}
