import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/constants/app_constants.dart';

/// Secure storage datasource for sensitive data
class SecureStorageDatasource {
  SecureStorageDatasource({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  /// Read auth token
  Future<String?> getAuthToken() async {
    return _storage.read(key: AppConstants.storageKeyAuthToken);
  }

  /// Save auth token
  Future<void> saveAuthToken(String token) async {
    await _storage.write(
      key: AppConstants.storageKeyAuthToken,
      value: token,
    );
  }

  /// Read refresh token
  Future<String?> getRefreshToken() async {
    return _storage.read(key: AppConstants.storageKeyRefreshToken);
  }

  /// Save refresh token
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(
      key: AppConstants.storageKeyRefreshToken,
      value: token,
    );
  }

  /// Read user ID
  Future<String?> getUserId() async {
    return _storage.read(key: AppConstants.storageKeyUserId);
  }

  /// Save user ID
  Future<void> saveUserId(String userId) async {
    await _storage.write(
      key: AppConstants.storageKeyUserId,
      value: userId,
    );
  }

  /// Clear all auth data
  Future<void> clearAuthData() async {
    await _storage.delete(key: AppConstants.storageKeyAuthToken);
    await _storage.delete(key: AppConstants.storageKeyRefreshToken);
    await _storage.delete(key: AppConstants.storageKeyUserId);
  }

  /// Delete specific key
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Read value by key
  Future<String?> read(String key) async {
    return _storage.read(key: key);
  }

  /// Write value by key
  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }
}
