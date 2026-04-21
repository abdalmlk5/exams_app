import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../data/datasources/auth_local_data_source_contract.dart';

abstract class AuthLocalDataSourceImplStirngs{
  static const String tokenKey = 'auth_token';
  static const String rememberMeKey = 'remember_me';
}

@Injectable(as: AuthLocalDataSourceContract)
class AuthLocalDataSourceImpl implements AuthLocalDataSourceContract {
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl(this.secureStorage);

  

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: AuthLocalDataSourceImplStirngs.tokenKey, value: token);
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: AuthLocalDataSourceImplStirngs.tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await secureStorage.delete(key: AuthLocalDataSourceImplStirngs.tokenKey);
  }

  @override
  Future<void> saveRememberMe(bool value) async {
    await secureStorage.write(key: AuthLocalDataSourceImplStirngs.rememberMeKey, value: value.toString());
  }

  @override
  Future<bool> getRememberMe() async {
    final value = await secureStorage.read(key: AuthLocalDataSourceImplStirngs.rememberMeKey);
    return value == 'true';
  }

  @override
  Future<void> deleteRememberMe() async {
    await secureStorage.delete(key: AuthLocalDataSourceImplStirngs.rememberMeKey);
  }
}
