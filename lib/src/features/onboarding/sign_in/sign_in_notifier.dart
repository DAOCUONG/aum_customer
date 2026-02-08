import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sign_in_state.dart';
import '../../../core/utils/validators.dart';
import '../../../core/providers/providers.dart';

/// Sign in screen notifier
class SignInNotifier extends AutoDisposeNotifier<SignInState> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  SignInState build() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    ref.onDispose(() {
      _emailController.dispose();
      _passwordController.dispose();
    });

    return const SignInState();
  }

  /// Get email controller
  TextEditingController get emailController => _emailController;

  /// Get password controller
  TextEditingController get passwordController => _passwordController;

  /// Set email
  void setEmail(String value) {
    state = state.copyWith(
      email: value,
      emailError: null,
      generalError: null,
    );
  }

  /// Set password
  void setPassword(String value) {
    state = state.copyWith(
      password: value,
      passwordError: null,
      generalError: null,
    );
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  /// Toggle remember me
  void toggleRememberMe() {
    state = state.copyWith(rememberMe: !state.rememberMe);
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(generalError: null);
  }

  /// Sign in with email and password
  Future<bool> signIn() async {
    // Validate inputs
    final emailResult = Validators.validateEmail(state.email);
    final passwordResult = Validators.validatePassword(state.password);

    final emailFailure = emailResult.fold(
      (failure) => failure,
      (_) => null,
    );
    if (emailFailure != null) {
      state = state.copyWith(emailError: emailFailure.message);
      return false;
    }

    final passwordFailure = passwordResult.fold(
      (failure) => failure,
      (_) => null,
    );
    if (passwordFailure != null) {
      state = state.copyWith(passwordError: passwordFailure.message);
      return false;
    }

    state = state.copyWith(isLoading: true, generalError: null);

    final useCase = ref.read(signInUseCaseProvider);

    final result = await useCase(
      email: state.email,
      password: state.password,
      rememberMe: state.rememberMe,
    ).run();

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          generalError: failure.message,
        );
        return false;
      },
      (authResult) {
        state = state.copyWith(isLoading: false);
        return authResult.isSuccess;
      },
    );
  }

  /// Sign in with Google
  Future<bool> signInWithGoogle() async {
    state = state.copyWith(isGoogleLoading: true, generalError: null);

    // Simulate Google sign in
    await Future.delayed(const Duration(seconds: 1));

    state = state.copyWith(isGoogleLoading: false);
    return true;
  }

  /// Sign in with Apple
  Future<bool> signInWithApple() async {
    state = state.copyWith(isAppleLoading: true, generalError: null);

    // Simulate Apple sign in
    await Future.delayed(const Duration(seconds: 1));

    state = state.copyWith(isAppleLoading: false);
    return true;
  }
}

/// Provider for sign in notifier
final signInNotifierProvider =
    AutoDisposeNotifierProvider<SignInNotifier, SignInState>(
  SignInNotifier.new,
);
