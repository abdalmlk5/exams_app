sealed class QuestionEvent {}

class GetQuestionsEvent extends QuestionEvent {
  final String examId;
  final int? page;
  final int? limit;

  GetQuestionsEvent({required this.examId, this.page, this.limit});
}

class NextQuestionsEvent extends QuestionEvent {}

class PerviousQuestionsEvent extends QuestionEvent {}

class SelectAnswersEvent extends QuestionEvent {
  final String questionId;
  final String answerKey;

  SelectAnswersEvent({required this.questionId, required this.answerKey});
}

class SubmitAnswersEvent extends QuestionEvent {}
