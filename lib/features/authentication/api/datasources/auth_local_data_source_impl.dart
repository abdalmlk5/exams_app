import 'package:exams_app/config/cache/cache_helper.dart';
import 'package:exams_app/core/utils/app_keys.dart';
import 'package:injectable/injectable.dart';

import '../../data/datasources/auth_local_data_source_contract.dart';

@Injectable(as: AuthLocalDataSourceContract)
class AuthLocalDataSourceImpl implements AuthLocalDataSourceContract {
  final CacheHelper _cacheHelper;

  AuthLocalDataSourceImpl(this._cacheHelper);

  @override
  Future<void> saveToken(String token) async {
    await _cacheHelper.writeData(key: AppKeys.tokenKey, value: token);
  }

  @override
  Future<String?> getToken() async {
    return await _cacheHelper.readData(key: AppKeys.tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await _cacheHelper.deleteData(key: AppKeys.tokenKey);
  }

  @override
  Future<void> saveRememberMe(bool value) async {
    await _cacheHelper.writeData(key: AppKeys.rememberMeKey, value: value);
  }

  @override
  Future<bool> getRememberMe() async {
    final value = await _cacheHelper.readData(key: AppKeys.rememberMeKey);
    return value == 'true';
  }

  @override
  Future<void> deleteRememberMe() async {
    await _cacheHelper.deleteData(key: AppKeys.rememberMeKey);
  }
}
