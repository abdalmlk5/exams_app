import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../api/end_points.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio();
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  }
}
