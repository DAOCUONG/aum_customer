import 'package:fpdart/fpdart.dart';
import '../../core/errors/failures.dart';
import '../entities/auth_result.dart';
import '../repository/auth_repository_interface.dart';

/// Use case for signing in with email and password
class SignInUseCase {
  const SignInUseCase({required this.authRepository});

  final AuthRepositoryInterface authRepository;

  TaskEither<Failure, AuthResult> call({
    required String email,
    required String password,
    bool rememberMe = false,
  }) {
    return authRepository.signIn(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
  }
}
