import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'location_permission_state.dart';
import '../../../core/providers/providers.dart';
import '../../../domain/entities/auth_result.dart';

/// Location permission screen notifier
class LocationPermissionNotifier extends AutoDisposeNotifier<LocationPermissionState> {
  @override
  LocationPermissionState build() {
    return const LocationPermissionState();
  }

  /// Request location permission
  Future<bool> requestPermission() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final useCase = ref.read(requestLocationPermissionUseCaseProvider);

    final result = await useCase().run();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
          isGranted: false,
          isDenied: true,
        );
        return false;
      },
      (permissionResult) {
        state = state.copyWith(
          isLoading: false,
          isGranted: permissionResult.isGranted,
          isDenied: !permissionResult.isGranted,
          isPermanentlyDenied:
              permissionResult.status == LocationPermissionStatus.permanentlyDenied,
        );
        return permissionResult.isGranted;
      },
    );

    return true;
  }

  /// Check current permission status
  Future<void> checkStatus() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    // Simulate checking status
    await Future.delayed(const Duration(milliseconds: 500));

    state = state.copyWith(isLoading: false);
  }

  /// Open settings
  Future<void> openSettings() async {
    state = state.copyWith(isLoading: true);

    // In a real app, use url_launcher to open settings
    await Future.delayed(const Duration(milliseconds: 500));

    state = state.copyWith(isLoading: false);
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// Provider for location permission notifier
final locationPermissionNotifierProvider =
    AutoDisposeNotifierProvider<LocationPermissionNotifier, LocationPermissionState>(
  LocationPermissionNotifier.new,
);
