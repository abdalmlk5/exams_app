import 'package:dio/dio.dart';
import 'package:exams_app/config/api/end_points.dart';
import 'package:exams_app/core/utils/app_keys.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../data/models/exams_response.dart';

part 'exams_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ExamsApiClient {
  @factoryMethod
  factory ExamsApiClient(Dio dio) = _ExamsApiClient;

  @GET(EndPoints.exams)
  Future<ExamsResponse> getExams(@Query(AppKeys.subject) String? subject);
}
