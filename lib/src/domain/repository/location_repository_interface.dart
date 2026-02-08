import 'package:fpdart/fpdart.dart';
import '../entities/auth_result.dart';
import '../../core/errors/failures.dart';

/// Repository interface for location operations
abstract class LocationRepositoryInterface {
  /// Request location permission
  TaskEither<Failure, LocationPermissionResult> requestPermission();

  /// Check current permission status
  TaskEither<Failure, LocationPermissionResult> checkPermissionStatus();

  /// Get current location coordinates
  TaskEither<Failure, (double latitude, double longitude)> getCurrentLocation();

  /// Open app settings for permission grant
  TaskEither<Failure, bool> openSettings();

  /// Check if location service is enabled
  TaskEither<Failure, bool> isLocationServiceEnabled();

  /// Save location permission status
  TaskEither<Failure, Unit> savePermissionStatus({required bool granted});

  /// Get saved location permission status
  TaskEither<Failure, bool> hasLocationPermission();
}
