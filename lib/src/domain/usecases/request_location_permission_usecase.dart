import 'package:fpdart/fpdart.dart';
import '../../core/errors/failures.dart';
import '../entities/auth_result.dart';
import '../repository/location_repository_interface.dart';

/// Use case for requesting location permission
class RequestLocationPermissionUseCase {
  const RequestLocationPermissionUseCase({
    required this.locationRepository,
  });

  final LocationRepositoryInterface locationRepository;

  TaskEither<Failure, LocationPermissionResult> call() {
    return locationRepository.requestPermission();
  }
}

/// Use case for checking location permission status
class CheckLocationPermissionUseCase {
  const CheckLocationPermissionUseCase({
    required this.locationRepository,
  });

  final LocationRepositoryInterface locationRepository;

  TaskEither<Failure, LocationPermissionResult> call() {
    return locationRepository.checkPermissionStatus();
  }
}

/// Use case for opening location settings
class OpenLocationSettingsUseCase {
  const OpenLocationSettingsUseCase({
    required this.locationRepository,
  });

  final LocationRepositoryInterface locationRepository;

  TaskEither<Failure, bool> call() {
    return locationRepository.openSettings();
  }
}
