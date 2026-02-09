import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'onboarding_state.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/providers/providers.dart';

/// Onboarding screen notifier
class OnboardingNotifier extends AutoDisposeNotifier<OnboardingState> {
  @override
  OnboardingState build() {
    return const OnboardingState();
  }

  /// Go to a specific page
  void goToPage(int page) {
    if (page >= 0 && page < OnboardingState.totalPages) {
      state = state.copyWith(currentPage: page);
    }
  }

  /// Navigate to next page
  void nextPage() {
    if (state.currentPage < OnboardingState.totalPages - 1) {
      state = state.copyWith(currentPage: state.currentPage + 1);
    }
  }

  /// Navigate to previous page
  void previousPage() {
    if (state.currentPage > 0) {
      state = state.copyWith(currentPage: state.currentPage - 1);
    }
  }

  /// Complete onboarding and navigate to sign in
  Future<void> completeOnboarding() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final useCase = ref.read(completeOnboardingUseCaseProvider);

    final result = await useCase().run();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
      },
      (_) {
        state = state.copyWith(isLoading: false);
      },
    );
  }

  /// Skip onboarding
  void skip() {
    completeOnboarding();
  }

  /// Reset to first page
  void reset() {
    state = state.copyWith(currentPage: 0);
  }
}

/// Provider for onboarding notifier
final onboardingNotifierProvider =
    AutoDisposeNotifierProvider<OnboardingNotifier, OnboardingState>(
  OnboardingNotifier.new,
);
