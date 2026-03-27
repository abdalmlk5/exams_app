import 'question_result_entity.dart';

class CheckQuestionsResponseEntity {
  final String message;
  final int correct;
  final int wrong;
  final String total;
  final List<QuestionResultEntity> wrongQuestions;
  final List<QuestionResultEntity> correctQuestions;

  CheckQuestionsResponseEntity({
    required this.message,
    required this.correct,
    required this.wrong,
    required this.total,
    required this.wrongQuestions,
    required this.correctQuestions,
  });
}
