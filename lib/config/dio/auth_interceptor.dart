import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../features/authentication/data/datasources/auth_local_data_source_contract.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final AuthLocalDataSourceContract _authLocalDataSource;

  AuthInterceptor(this._authLocalDataSource);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _authLocalDataSource.getToken();

    if (token != null) {
      options.headers['token'] = token;
    }

    handler.next(options);
  }
}
