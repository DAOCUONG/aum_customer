import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state.freezed.dart';

/// Onboarding screen state
@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(0) int currentPage,
    @Default(false) bool isLoading,
    @Default(false) bool isCompleting,
    String? errorMessage,
  }) = _OnboardingState;

  /// Total number of pages
  static const int totalPages = 3;
}

/// Extension methods
extension OnboardingStateX on OnboardingState {
  /// Check if this is the first page
  bool get isFirstPage => currentPage == 0;

  /// Check if this is the last page
  bool get isLastPage => currentPage == OnboardingState.totalPages - 1;

  /// Check if onboarding is in progress
  bool get isInProgress => !isFirstPage && !isLastPage;

  /// Check if has error
  bool get hasError => errorMessage != null;
}
