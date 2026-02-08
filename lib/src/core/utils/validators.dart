import 'package:fpdart/fpdart.dart';
import '../errors/failures.dart';

/// Validator result type using fpdart
typedef ValidationResult<T> = Either<ValidationFailure, T>;

/// Email validation result
typedef EmailValidationResult = ValidationResult<String>;

/// Password validation result
typedef PasswordValidationResult = ValidationResult<String>;

/// Validators for user input
class Validators {
  /// Validates an email address
  static EmailValidationResult validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return left(const ValidationFailure(
        message: 'Email is required',
        code: 'email_required',
        field: 'email',
      ));
    }

    final trimmedEmail = email.trim();
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(trimmedEmail)) {
      return left(const ValidationFailure(
        message: 'Please enter a valid email address',
        code: 'email_invalid',
        field: 'email',
      ));
    }

    return right(trimmedEmail);
  }

  /// Validates a password
  static PasswordValidationResult validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return left(const ValidationFailure(
        message: 'Password is required',
        code: 'password_required',
        field: 'password',
      ));
    }

    const minPasswordLength = 8;

    if (password.length < minPasswordLength) {
      return left(ValidationFailure(
        message: 'Password must be at least $minPasswordLength characters',
        code: 'password_too_short',
        field: 'password',
      ));
    }

    // Check for at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return left(const ValidationFailure(
        message: 'Password must contain at least one uppercase letter',
        code: 'password_no_uppercase',
        field: 'password',
      ));
    }

    // Check for at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      return left(const ValidationFailure(
        message: 'Password must contain at least one lowercase letter',
        code: 'password_no_lowercase',
        field: 'password',
      ));
    }

    // Check for at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      return left(const ValidationFailure(
        message: 'Password must contain at least one digit',
        code: 'password_no_digit',
        field: 'password',
      ));
    }

    return right(password);
  }

  /// Validates a confirm password field
  static PasswordValidationResult validateConfirmPassword(
    String password,
    String confirmPassword,
  ) {
    if (confirmPassword.isEmpty) {
      return left(const ValidationFailure(
        message: 'Please confirm your password',
        code: 'confirm_password_required',
        field: 'confirmPassword',
      ));
    }

    if (password != confirmPassword) {
      return left(const ValidationFailure(
        message: 'Passwords do not match',
        code: 'password_mismatch',
        field: 'confirmPassword',
      ));
    }

    return right(confirmPassword);
  }

  /// Validates that a field is not empty
  static ValidationResult<String> validateNotEmpty(
    String? value,
    String fieldName,
  ) {
    if (value == null || value.trim().isEmpty) {
      return left(ValidationFailure(
        message: '$fieldName is required',
        code: '${fieldName.toLowerCase()}_required',
        field: fieldName.toLowerCase(),
      ));
    }

    return right(value.trim());
  }
}
