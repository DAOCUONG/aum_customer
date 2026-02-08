import 'package:fpdart/fpdart.dart';
import '../../core/errors/failures.dart';
import '../entities/auth_result.dart';
import '../repository/auth_repository_interface.dart';

/// Use case for signing up with email and password
class SignUpUseCase {
  const SignUpUseCase({required this.authRepository});

  final AuthRepositoryInterface authRepository;

  TaskEither<Failure, AuthResult> call({
    required String email,
    required String password,
    String? displayName,
  }) {
    return authRepository.signUp(
      email: email,
      password: password,
      displayName: displayName,
    );
  }
}
