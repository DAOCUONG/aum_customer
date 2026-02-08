import 'package:fpdart/fpdart.dart';
import '../../core/errors/failures.dart';
import '../../core/constants/app_constants.dart';
import '../datasource/local/secure_storage_datasource.dart';
import '../models/user_model.dart';
import '../datasource/local/preferences_datasource.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/auth_result.dart';
import '../../domain/repository/auth_repository_interface.dart';

/// Implementation of AuthRepositoryInterface
class AuthRepositoryImpl implements AuthRepositoryInterface {
  AuthRepositoryImpl({
    required SecureStorageDatasource secureStorage,
    required PreferencesDatasource preferences,
  })  : _secureStorage = secureStorage,
        _preferences = preferences;

  final SecureStorageDatasource _secureStorage;
  final PreferencesDatasource _preferences;

  @override
  TaskEither<Failure, AuthResult> signIn({
    required String email,
    required String password,
    bool rememberMe = false,
  }) {
    return TaskEither.tryCatch(
      () async {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 1));

        // For demo purposes, accept any email/password
        if (email.isEmpty || password.isEmpty) {
          throw const AuthFailure(
            message: 'Invalid credentials',
            code: 'invalid_credentials',
            errorType: AuthErrorType.invalidCredentials,
          );
        }

        // Create mock user
        final user = UserEntity(
          id: 'user_${DateTime.now().millisecondsSinceEpoch}',
          email: email,
          displayName: email.split('@').first,
          isEmailVerified: true,
          createdAt: DateTime.now(),
        );

        // Generate mock tokens
        final token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
        final refreshToken = 'mock_refresh_${DateTime.now().millisecondsSinceEpoch}';

        // Save tokens
        await _secureStorage.saveAuthToken(token);
        await _secureStorage.saveRefreshToken(refreshToken);
        await _secureStorage.saveUserId(user.id);

        if (rememberMe) {
          await _preferences.setBool(key: 'remember_me', value: true);
        }

        return AuthResult.successWith(
          user: user,
          token: token,
          refreshToken: refreshToken,
        );
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
  TaskEither<Failure, AuthResult> signUp({
    required String email,
    required String password,
    String? displayName,
  }) {
    return TaskEither.tryCatch(
      () async {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 1));

        if (email.isEmpty || password.isEmpty) {
          throw const ValidationFailure(
            message: 'Email and password are required',
            code: 'validation_error',
            field: 'credentials',
          );
        }

        // Create mock user
        final user = UserEntity(
          id: 'user_${DateTime.now().millisecondsSinceEpoch}',
          email: email,
          displayName: displayName ?? email.split('@').first,
          isEmailVerified: false,
          createdAt: DateTime.now(),
        );

        final token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';

        await _secureStorage.saveAuthToken(token);
        await _secureStorage.saveUserId(user.id);

        return AuthResult.successWith(
          user: user,
          token: token,
        );
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
  TaskEither<Failure, Unit> signOut() {
    return TaskEither.tryCatch(
      () async {
        await _secureStorage.clearAuthData();
        return unit;
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
  TaskEither<Failure, bool> isSignedIn() {
    return TaskEither.tryCatch(
      () async {
        final token = await _secureStorage.getAuthToken();
        return token != null && token.isNotEmpty;
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
  TaskEither<Failure, UserEntity> getCurrentUser() {
    return TaskEither.tryCatch(
      () async {
        final userId = await _secureStorage.getUserId();
        if (userId == null) {
          throw const AuthFailure(
            message: 'No user logged in',
            code: 'no_user',
            errorType: AuthErrorType.userNotFound,
          );
        }

        // In a real app, fetch user from API
        return UserEntity(
          id: userId,
          email: await _secureStorage.read('user_email'),
          displayName: await _secureStorage.read('user_display_name'),
        );
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
  TaskEither<Failure, AuthResult> signInWithGoogle() {
    return TaskEither.tryCatch(
      () async {
        // Simulate Google sign in
        await Future.delayed(const Duration(seconds: 1));

        final user = UserEntity(
          id: 'google_user_${DateTime.now().millisecondsSinceEpoch}',
          email: 'user@gmail.com',
          displayName: 'Google User',
          photoUrl: 'https://example.com/photo.jpg',
          isEmailVerified: true,
          createdAt: DateTime.now(),
        );

        final token = 'google_token_${DateTime.now().millisecondsSinceEpoch}';

        await _secureStorage.saveAuthToken(token);
        await _secureStorage.saveUserId(user.id);

        return AuthResult.successWith(
          user: user,
          token: token,
        );
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
  TaskEither<Failure, AuthResult> signInWithApple() {
    return TaskEither.tryCatch(
      () async {
        // Simulate Apple sign in
        await Future.delayed(const Duration(seconds: 1));

        final user = UserEntity(
          id: 'apple_user_${DateTime.now().millisecondsSinceEpoch}',
          email: 'user@icloud.com',
          displayName: 'Apple User',
          isEmailVerified: true,
          createdAt: DateTime.now(),
        );

        final token = 'apple_token_${DateTime.now().millisecondsSinceEpoch}';

        await _secureStorage.saveAuthToken(token);
        await _secureStorage.saveUserId(user.id);

        return AuthResult.successWith(
          user: user,
          token: token,
        );
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
  TaskEither<Failure, Unit> resetPassword({required String email}) {
    return TaskEither.tryCatch(
      () async {
        await Future.delayed(const Duration(seconds: 1));
        return unit;
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
  TaskEither<Failure, UserEntity> updateProfile({
    String? displayName,
    String? photoUrl,
  }) {
    return TaskEither.tryCatch(
      () async {
        final userId = await _secureStorage.getUserId();
        if (displayName != null) {
          await _secureStorage.write(
            key: 'user_display_name',
            value: displayName,
          );
        }
        if (photoUrl != null) {
          await _secureStorage.write(
            key: 'user_photo_url',
            value: photoUrl,
          );
        }

        return UserEntity(
          id: userId ?? '',
          displayName: displayName,
          photoUrl: photoUrl,
        );
      },
      (error, stackTrace) => error is Failure
          ? error
          : UnexpectedFailure(
              message: error.toString(),
              stackTrace: stackTrace,
            ),
    );
  }
}
