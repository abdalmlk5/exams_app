import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/questions/domain/entities/check_questions_response_entity.dart';
import 'package:exams_app/features/questions/domain/entities/submit_answers_request_entity.dart';
import 'package:exams_app/features/questions/domain/repositories/question_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubmitAnswersUsecase {
  final QuestionRepoContract questionRepoContract;

  SubmitAnswersUsecase({required this.questionRepoContract});

  Future<BaseResponse<CheckQuestionsResponseEntity>> call({
    required SubmitAnswersRequestEntity body,
  }) async {
    return await questionRepoContract.checkQuestions(body: body);
  }
}
