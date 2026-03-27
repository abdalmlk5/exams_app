import 'answer_check_item_entity.dart';

class SubmitAnswersRequestEntity {
  final List<AnswerCheckItemEntity> answers;
  final int time;

  SubmitAnswersRequestEntity({required this.answers, required this.time});
}
