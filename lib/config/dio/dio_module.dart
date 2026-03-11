import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../api/end_points.dart';
import '../../features/authentication/data/datasources/auth_local_data_source_contract.dart';

@module
abstract class DioModule {

  @lazySingleton
  Dio dio(AuthLocalDataSourceContract authLocalDataSource) {

    final dio = Dio();

    dio.options.baseUrl = EndPoints.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {

          final token = await authLocalDataSource.getToken();

          if (token != null) {
            options.headers['token'] = token;
          }

          handler.next(options);
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );

    return dio;
  }
}