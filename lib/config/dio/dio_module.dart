import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../api/end_points.dart';
import 'package:flutter/foundation.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio();
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    // Using Logger for pretty logging since pretty_dio_logger is not in pubspec
    final logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 5,
        lineLength: 75,
        colors: true,
        printEmojis: true,
        printTime: false,
      ),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            logger.i("REQUEST[${options.method}] => PATH: ${options.path}");
            if (kDebugMode) {
              logger.d("Data: ${options.data}");
            }
            return handler.next(options);
          },
          onResponse: (response, handler) {
            logger.i(
              "RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}",
            );
            if (kDebugMode) {
              logger.d("Data: ${response.data}");
            }
            return handler.next(response);
          },
          onError: (DioException e, handler) {
            logger.e(
              "ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}",
            );
            logger.e("Message: ${e.message}");
            if (kDebugMode) {
              logger.e("Response Data: ${e.response?.data}");
            }
            return handler.next(e);
          },
        ),
      );
    }

    dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    return dio;
  }
}
