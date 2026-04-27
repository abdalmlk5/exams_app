import 'package:injectable/injectable.dart';
import '../../../../config/cache/cache_helper.dart';
import '../../data/datasources/auth_local_data_source_contract.dart';

@Injectable(as: AuthLocalDataSourceContract)
class AuthLocalDataSourceImpl implements AuthLocalDataSourceContract {
  final CacheHelper _cacheHelper;

  AuthLocalDataSourceImpl(this._cacheHelper);

  static const String _tokenKey = 'auth_token';
  static const String _rememberMeKey = 'remember_me';

  @override
  Future<void> saveToken(String token) async {
    await _cacheHelper.writeData(key: _tokenKey, value: token);
  }

  @override
  Future<String?> getToken() async {
    return await _cacheHelper.readData(key: _tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await _cacheHelper.deleteData(key: _tokenKey);
  }

  @override
  Future<void> saveRememberMe(bool value) async {
    await _cacheHelper.writeData(key: _rememberMeKey, value: value.toString());
  }

  @override
  Future<bool> getRememberMe() async {
    final value = await _cacheHelper.readData(key: _rememberMeKey);
    return value == 'true';
  }

  @override
  Future<void> deleteRememberMe() async {
    await _cacheHelper.deleteData(key: _rememberMeKey);
  }
}
