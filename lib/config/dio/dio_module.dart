import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../api/end_points.dart';
import '../interceptors/auth_interceptor.dart';
import '../interceptors/logging_interceptor.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio(
    AuthInterceptor authInterceptor,
    LoggingInterceptor loggingInterceptor,
  ) {
    final dio = Dio();

    dio.options.baseUrl = EndPoints.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

<<<<<<< HEAD
    if (kDebugMode) {
      final logger = Logger(
        printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 5,
          lineLength: 75,
          colors: true,
          printEmojis: true,
          dateTimeFormat: DateTimeFormat.none,
        ),
      );

      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            logger.i("REQUEST[${options.method}] => PATH: ${options.path}");
            logger.d("Data: ${options.data}");
            return handler.next(options);
          },
          onResponse: (response, handler) {
            logger.i(
              "RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}",
            );
            logger.d("Data: ${response.data}");
            return handler.next(response);
          },
          onError: (DioException e, handler) {
            logger.e(
              "ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}",
            );
            logger.e("Message: ${e.message}");
            logger.e("Response Data: ${e.response?.data}");
            return handler.next(e);
          },
        ),
      );
    }

=======
>>>>>>> feature/explore-subjects-list
    dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

<<<<<<< HEAD
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
=======
    dio.interceptors.addAll([authInterceptor, loggingInterceptor]);
>>>>>>> feature/explore-subjects-list

    return dio;
  }
}
