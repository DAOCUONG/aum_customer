/// Application-wide constants
class AppConstants {
  AppConstants._();

  // Animation durations
  static const splashDuration = Duration(milliseconds: 2500);
  static const animationDurationShort = Duration(milliseconds: 200);
  static const animationDurationMedium = Duration(milliseconds: 400);
  static const animationDurationLong = Duration(milliseconds: 600);

  // Network timeouts
  static const connectTimeout = Duration(seconds: 30);
  static const receiveTimeout = Duration(seconds: 30);
  static const sendTimeout = Duration(seconds: 30);

  // Retry configuration
  static const maxRetryAttempts = 3;
  static const retryDelayBase = Duration(milliseconds: 500);

  // Pagination
  static const defaultPageSize = 20;
  static const defaultPageNumber = 1;

  // Onboarding
  static const onboardingPageCount = 3;

  // Storage keys
  static const storageKeyAuthToken = 'auth_token';
  static const storageKeyRefreshToken = 'refresh_token';
  static const storageKeyUserId = 'user_id';
  static const storageKeyOnboardingCompleted = 'onboarding_completed';
  static const storageKeyPreferencesSaved = 'preferences_saved';
}
