import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/config/error_handler/error_handler.dart';
import 'package:exams_app/features/questions/api/api_client/question_api_client.dart';
import 'package:exams_app/features/questions/data/datasources/question_remote_data_source_contract.dart';
import 'package:exams_app/features/questions/data/models/check_questions_response_model.dart';
import 'package:exams_app/features/questions/data/models/question_model.dart';
import 'package:exams_app/features/questions/data/models/submit_answers_request_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: QuestionRemoteDataSourceContract)
class QuestionRemoteDataSourceImpl implements QuestionRemoteDataSourceContract {
  final QuestionApiClient _questionApiClient;

  QuestionRemoteDataSourceImpl({required QuestionApiClient questionApiClient})
    : _questionApiClient = questionApiClient;
  @override
  Future<BaseResponse<List<QuestionModel>>> getQuestions({
    required String examId,
    int? page,
    int? limit,
  }) async {
    try {
      final response = await _questionApiClient.getQuestions(
        examId: examId,
        page: page,
        limit: limit,
      );

      return SuccessBaseResponse(response.questions);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<CheckQuestionsResponseModel>> checkQuestions({
    required SubmitAnswersRequestModel body,
  }) async {
    try {
      final response = await _questionApiClient.checkQuestions(body: body);
      return SuccessBaseResponse(response);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }
}
