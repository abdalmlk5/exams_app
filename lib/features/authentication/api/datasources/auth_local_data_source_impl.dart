import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../data/datasources/auth_local_data_source_contract.dart';

@Injectable(as: AuthLocalDataSourceContract)
class AuthLocalDataSourceImpl implements AuthLocalDataSourceContract {
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl(this.secureStorage);

  static const String _tokenKey = 'auth_token';
  static const String _rememberMeKey = 'remember_me';

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: _tokenKey, value: token);
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: _tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await secureStorage.delete(key: _tokenKey);
  }

  @override
  Future<void> saveRememberMe(bool value) async {
    await secureStorage.write(key: _rememberMeKey, value: value.toString());
  }

  @override
  Future<bool> getRememberMe() async {
    final value = await secureStorage.read(key: _rememberMeKey);
    return value == 'true';
  }

  @override
  Future<void> deleteRememberMe() async {
    await secureStorage.delete(key: _rememberMeKey);
  }
}
