import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';

/// Local preferences datasource for non-sensitive data
class PreferencesDatasource {
  PreferencesDatasource({SharedPreferences? preferences}) : _prefs = preferences;

  final SharedPreferences? _prefs;

  /// Get SharedPreferences instance
  Future<SharedPreferences> getPrefs() async {
    return _prefs ?? await SharedPreferences.getInstance();
  }

  /// Check if onboarding is completed
  Future<bool> hasCompletedOnboarding() async {
    final prefs = await getPrefs();
    return prefs.getBool(AppConstants.storageKeyOnboardingCompleted) ?? false;
  }

  /// Set onboarding completed
  Future<void> setOnboardingCompleted() async {
    final prefs = await getPrefs();
    await prefs.setBool(AppConstants.storageKeyOnboardingCompleted, true);
  }

  /// Check if preferences are saved
  Future<bool> hasSavedPreferences() async {
    final prefs = await getPrefs();
    return prefs.getBool(AppConstants.storageKeyPreferencesSaved) ?? false;
  }

  /// Set preferences saved
  Future<void> setPreferencesSaved() async {
    final prefs = await getPrefs();
    await prefs.setBool(AppConstants.storageKeyPreferencesSaved, true);
  }

  /// Check if location permission was granted
  Future<bool> hasLocationPermission() async {
    final prefs = await getPrefs();
    return prefs.getBool('location_permission_granted') ?? false;
  }

  /// Set location permission status
  Future<void> setLocationPermission({required bool granted}) async {
    final prefs = await getPrefs();
    await prefs.setBool('location_permission_granted', granted);
  }

  /// Save dietary preferences
  Future<void> saveDietaryPreferences(List<String> preferenceIds) async {
    final prefs = await getPrefs();
    await prefs.setStringList('dietary_preferences', preferenceIds);
  }

  /// Get dietary preferences
  Future<List<String>> getDietaryPreferences() async {
    final prefs = await getPrefs();
    return prefs.getStringList('dietary_preferences') ?? [];
  }

  /// Clear dietary preferences
  Future<void> clearDietaryPreferences() async {
    final prefs = await getPrefs();
    await prefs.remove('dietary_preferences');
  }

  /// Get a string value
  Future<String?> getString({required String key}) async {
    final prefs = await getPrefs();
    return prefs.getString(key);
  }

  /// Set a string value
  Future<void> setString({required String key, required String value}) async {
    final prefs = await getPrefs();
    await prefs.setString(key, value);
  }

  /// Get a bool value
  Future<bool?> getBool({required String key}) async {
    final prefs = await getPrefs();
    return prefs.getBool(key);
  }

  /// Set a bool value
  Future<void> setBool({required String key, required bool value}) async {
    final prefs = await getPrefs();
    await prefs.setBool(key, value);
  }

  /// Clear all preferences
  Future<void> clearAll() async {
    final prefs = await getPrefs();
    await prefs.clear();
  }
}
