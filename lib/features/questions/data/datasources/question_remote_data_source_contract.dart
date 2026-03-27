import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/questions/data/models/check_questions_response_model.dart';
import 'package:exams_app/features/questions/data/models/question_model.dart';
import 'package:exams_app/features/questions/data/models/submit_answers_request_model.dart';

abstract class QuestionRemoteDataSourceContract {
  Future<BaseResponse<List<QuestionModel>>> getQuestions({
    required String examId,
    int? page,
    int? limit,
  });
  Future<BaseResponse<CheckQuestionsResponseModel>> checkQuestions({
    required SubmitAnswersRequestModel body,
  });
}
