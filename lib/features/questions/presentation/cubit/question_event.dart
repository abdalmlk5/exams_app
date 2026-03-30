import 'package:exams_app/features/questions/domain/entities/submit_answers_request_entity.dart';

sealed class QuestionEvent {}

class GetQuestionsEvent extends QuestionEvent {
  final String examId;
  final int? page;
  final int? limit;

  GetQuestionsEvent({
    required this.examId,
    this.page,
    this.limit,
  });
}

class SubmitAnswersEvent extends QuestionEvent {
  final SubmitAnswersRequestEntity body;

  SubmitAnswersEvent({required this.body});
}