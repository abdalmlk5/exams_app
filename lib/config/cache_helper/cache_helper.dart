import 'package:exams_app/core/utils/app_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CacheHelper {
  final FlutterSecureStorage _secureStorage;

  CacheHelper(this._secureStorage);

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: AppKeys.tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: AppKeys.tokenKey);
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: AppKeys.tokenKey);
  }

  Future<void> saveRememberMe(bool value) async {
    await _secureStorage.write(
      key: AppKeys.rememberMeKey,
      value: value.toString(),
    );
  }

  Future<bool> getRememberMe() async {
    String? value = await _secureStorage.read(key: AppKeys.rememberMeKey);
    return value == 'true';
  }

  Future<void> writeData({required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> readData({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> deleteData({required String key}) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> clearAllData() async {
    await _secureStorage.deleteAll();
  }
}
