import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

/// Sign in screen state
@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool obscurePassword,
    @Default(false) bool rememberMe,
    @Default(false) bool isLoading,
    @Default(false) bool isGoogleLoading,
    @Default(false) bool isAppleLoading,
    String? emailError,
    String? passwordError,
    String? generalError,
  }) = _SignInState;
}

/// Extension methods
extension SignInStateX on SignInState {
  /// Check if email is valid
  bool get emailIsValid {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// Check if form is valid
  bool get isFormValid {
    return email.isNotEmpty &&
        password.isNotEmpty &&
        emailError == null &&
        passwordError == null;
  }

  /// Check if has any error
  bool get hasError =>
      emailError != null ||
      passwordError != null ||
      generalError != null;

  /// Check if any social login is loading
  bool get isAnySocialLoading => isGoogleLoading || isAppleLoading;
}
