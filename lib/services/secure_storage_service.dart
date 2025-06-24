import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  static Future<void> storeAuthToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  static Future<String?> getAuthToken() async {
    final token = await _storage.read(key: 'auth_token');

    return token;
  }

  static Future<void> deleteAuthToken() async {
    await _storage.delete(key: 'auth_token');
  }
}
