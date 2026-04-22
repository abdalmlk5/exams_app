import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../api/end_points.dart';
import 'auth_interceptor.dart';

@module
abstract class DioModule {

  @lazySingleton
  Dio dio(AuthInterceptor authInterceptor) {

    final dio = Dio();

    dio.options.baseUrl = EndPoints.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    dio.interceptors.add(authInterceptor);

    if (!kReleaseMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }

    return dio;
  }
}