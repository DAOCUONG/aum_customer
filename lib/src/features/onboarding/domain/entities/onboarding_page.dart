import 'package:flutter/material.dart';

/// Domain Entity representing an onboarding page
///
/// Contains pure business logic for onboarding page data
/// with no external dependencies
@immutable
class OnboardingPageEntity {
  final String id;
  final String title;
  final String description;
  final List<String> foodImagePaths;
  final int totalPages;
  final int currentPageIndex;

  const OnboardingPageEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.foodImagePaths,
    required this.totalPages,
    required this.currentPageIndex,
  });

  /// Check if this is the first page
  bool get isFirstPage => currentPageIndex == 0;

  /// Check if this is the last page
  bool get isLastPage => currentPageIndex == totalPages - 1;

  /// Get the next page index, or null if last page
  int? get nextPageIndex => isLastPage ? null : currentPageIndex + 1;

  /// Get the previous page index, or null if first page
  int? get previousPageIndex => isFirstPage ? null : currentPageIndex - 1;

  /// Calculate vertical offset for staggered food grid layout
  /// Food items at even indices (0, 2) have upward offset
  /// Food items at odd indices (1, 3) have downward offset
  double getVerticalOffset(int itemIndex) {
    if (itemIndex % 2 == 0) {
      return -32.0; // Upward offset for even indices
    } else {
      return 32.0; // Downward offset for odd indices
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OnboardingPageEntity &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.currentPageIndex == currentPageIndex;
  }

  @override
  int get hashCode => Object.hash(id, title, description, currentPageIndex);
}

/// Enum for onboarding step types
enum OnboardingStepType {
  discover,
  order,
  enjoy;

  String getNextRoute() {
    switch (this) {
      case discover:
        return '/signIn'; // Navigate to sign in for now
      case order:
        return '/signIn';
      case enjoy:
        return '/home';
    }
  }
}

/// Onboarding configuration entity
@immutable
class OnboardingConfigEntity {
  final List<OnboardingPageEntity> pages;
  final String skipRoute;
  final String signInRoute;

  const OnboardingConfigEntity({
    required this.pages,
    required this.skipRoute,
    required this.signInRoute,
  });

  /// Get the page at specified index
  OnboardingPageEntity getPage(int index) => pages[index];

  /// Total number of onboarding pages
  int get totalPages => pages.length;
}
