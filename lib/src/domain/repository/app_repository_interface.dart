import 'package:fpdart/fpdart.dart';
import '../entities/auth_result.dart';
import '../../core/errors/failures.dart';

/// Repository interface for app initialization operations
abstract class AppRepositoryInterface {
  /// Initialize the app
  TaskEither<Failure, InitializationResult> initialize();

  /// Check if this is the first launch
  TaskEither<Failure, bool> isFirstLaunch();

  /// Get the current auth token
  TaskEither<Failure, String?> getAuthToken();

  /// Save the auth token
  TaskEither<Failure, Unit> saveAuthToken({required String token});

  /// Clear the auth token
  TaskEither<Failure, Unit> clearAuthToken();
}
