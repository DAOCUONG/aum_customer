import 'package:fpdart/fpdart.dart';
import '../../core/errors/failures.dart';
import '../datasource/local/preferences_datasource.dart';
import '../../domain/entities/auth_result.dart';
import '../../domain/repository/location_repository_interface.dart';

/// Implementation of LocationRepositoryInterface
class LocationRepositoryImpl implements LocationRepositoryInterface {
  LocationRepositoryImpl({required PreferencesDatasource preferences})
      : _preferences = preferences;

  final PreferencesDatasource _preferences;

  @override
  TaskEither<Failure, LocationPermissionResult> requestPermission() {
    return TaskEither.tryCatch(
      () async {
        // Simulate permission request
        // In a real app, use permission_handler package
        await Future.delayed(const Duration(milliseconds: 500));

        // For demo purposes, return granted
        return const LocationPermissionResult(
          status: LocationPermissionStatus.granted,
          isGranted: true,
          canAskAgain: true,
        );
      },
      (error, stackTrace) => error is Failure
          ? error
          : PermissionFailure(
              message: error.toString(),
              code: 'permission_denied',
              stackTrace: stackTrace,
              permissionType: 'location',
            ),
    );
  }

  @override
  TaskEither<Failure, LocationPermissionResult> checkPermissionStatus() {
    return TaskEither.tryCatch(
      () async {
        // Check if permission was previously granted
        final hasPermission = await _preferences.hasLocationPermission();

        return LocationPermissionResult(
          status: hasPermission
              ? LocationPermissionStatus.granted
              : LocationPermissionStatus.denied,
          isGranted: hasPermission,
          canAskAgain: true,
        );
      },
      (error, stackTrace) => error is Failure
          ? error
          : PermissionFailure(
              message: error.toString(),
              code: 'permission_check_failed',
              stackTrace: stackTrace,
              permissionType: 'location',
            ),
    );
  }

  @override
  TaskEither<Failure, (double latitude, double longitude)>
      getCurrentLocation() {
    return TaskEither.tryCatch(
      () async {
        // Simulate getting location
        await Future.delayed(const Duration(milliseconds: 500));

        // Mock coordinates
        return (37.7749, -122.4194); // San Francisco
      },
      (error, stackTrace) => error is Failure
          ? error
          : PermissionFailure(
              message: error.toString(),
              code: 'location_unavailable',
              stackTrace: stackTrace,
              permissionType: 'location',
            ),
    );
  }

  @override
  TaskEither<Failure, bool> openSettings() {
    return TaskEither.tryCatch(
      () async {
        // In a real app, use url_launcher or device_info
        await Future.delayed(const Duration(milliseconds: 200));
        return true;
      },
      (error, stackTrace) => error is Failure
          ? error
          : UnexpectedFailure(
              message: error.toString(),
              stackTrace: stackTrace,
            ),
    );
  }

  @override
  TaskEither<Failure, bool> isLocationServiceEnabled() {
    return TaskEither.tryCatch(
      () async {
        // Check if location services are enabled
        await Future.delayed(const Duration(milliseconds: 100));
        return true; // Mock as enabled
      },
      (error, stackTrace) => error is Failure
          ? error
          : UnexpectedFailure(
              message: error.toString(),
              stackTrace: stackTrace,
            ),
    );
  }

  @override
  TaskEither<Failure, Unit> savePermissionStatus({required bool granted}) {
    return TaskEither.tryCatch(
      () async {
        await _preferences.setLocationPermission(granted: granted);
        return unit;
      },
      (error, stackTrace) => error is Failure
          ? error
          : CacheFailure(
              message: error.toString(),
              stackTrace: stackTrace,
            ),
    );
  }

  @override
  TaskEither<Failure, bool> hasLocationPermission() {
    return TaskEither.tryCatch(
      () async {
        return _preferences.hasLocationPermission();
      },
      (error, stackTrace) => error is Failure
          ? error
          : CacheFailure(
              message: error.toString(),
              stackTrace: stackTrace,
            ),
    );
  }
}
