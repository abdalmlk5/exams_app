import 'package:dio/dio.dart';
import 'package:exams_app/config/api/api_param.dart';
import 'package:exams_app/config/api/end_points.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../data/models/check_questions_response_model.dart';
import '../../data/models/submit_answers_request_model.dart';
import '../../data/response/question_response_model.dart';

part 'question_api_client.g.dart';

@injectable
@RestApi()
abstract class QuestionApiClient {
  @factoryMethod
  factory QuestionApiClient(Dio dio) = _QuestionApiClient;

  @GET(EndPoints.getQuestions)
  Future<QuestionResponseModel> getQuestions({
    @Query(ApiParam.examId) required String examId,
    @Query(ApiParam.page) int? page,
    @Query(ApiParam.limit) int? limit,
  });

  @POST(EndPoints.checkQuestions)
  Future<CheckQuestionsResponseModel> checkQuestions({
    @Body() required SubmitAnswersRequestModel body,
  });
}