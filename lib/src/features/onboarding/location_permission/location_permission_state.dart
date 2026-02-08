import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_permission_state.freezed.dart';

/// Location permission screen state
@freezed
class LocationPermissionState with _$LocationPermissionState {
  const factory LocationPermissionState({
    @Default(false) bool isLoading,
    @Default(false) bool isGranted,
    @Default(false) bool isPermanentlyDenied,
    @Default(false) bool isDenied,
    String? errorMessage,
  }) = _LocationPermissionState;
}

/// Extension methods
extension LocationPermissionStateX on LocationPermissionState {
  /// Check if permission is available
  bool get hasPermission => isGranted;

  /// Check if can request permission
  bool get canRequest => !isPermanentlyDenied && !isGranted;

  /// Check if needs settings
  bool get needsSettings => isPermanentlyDenied || (isDenied && !canRequest);

  /// Check if has error
  bool get hasError => errorMessage != null;
}
