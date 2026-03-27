import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/questions/domain/entities/question_entity.dart';
import 'package:exams_app/features/questions/domain/repositories/question_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetQuestionsUsecase {
  final QuestionRepoContract questionRepoContract;

  GetQuestionsUsecase({required this.questionRepoContract});

  Future<BaseResponse<List<QuestionEntity>>> call({
    required String examId,
  }) async {
    return await questionRepoContract.getQuestions(examId: examId);
  }
}
