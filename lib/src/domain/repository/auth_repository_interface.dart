import 'package:fpdart/fpdart.dart';
import '../entities/user_entity.dart';
import '../entities/auth_result.dart';
import '../../core/errors/failures.dart';

/// Repository interface for authentication operations
abstract class AuthRepositoryInterface {
  /// Sign in with email and password
  TaskEither<Failure, AuthResult> signIn({
    required String email,
    required String password,
    bool rememberMe = false,
  });

  /// Sign up with email and password
  TaskEither<Failure, AuthResult> signUp({
    required String email,
    required String password,
    String? displayName,
  });

  /// Sign out the current user
  TaskEither<Failure, Unit> signOut();

  /// Check if user is currently signed in
  TaskEither<Failure, bool> isSignedIn();

  /// Get the current authenticated user
  TaskEither<Failure, UserEntity> getCurrentUser();

  /// Sign in with Google
  TaskEither<Failure, AuthResult> signInWithGoogle();

  /// Sign in with Apple
  TaskEither<Failure, AuthResult> signInWithApple();

  /// Request password reset email
  TaskEither<Failure, Unit> resetPassword({required String email});

  /// Update user profile
  TaskEither<Failure, UserEntity> updateProfile({
    String? displayName,
    String? photoUrl,
  });
}
