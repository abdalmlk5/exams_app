import 'package:exams_app/config/base_response/base_response.dart';
import '../entities/check_questions_response_entity.dart';
import '../entities/question_entity.dart';
import '../entities/submit_answers_request_entity.dart';

abstract class QuestionRepoContract {
  Future<BaseResponse<List<QuestionEntity>>> getQuestions({
    required String examId,
    int? page,
    int? limit,
  });

  Future<BaseResponse<CheckQuestionsResponseEntity>> checkQuestions({
    required SubmitAnswersRequestEntity body,
  });
}