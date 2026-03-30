class QuestionResultEntity {
  final String qid;
  final String question;
  final String? inCorrectAnswer;
  final String correctAnswer;
  final Map<String, dynamic>? answers;

  QuestionResultEntity({
    required this.qid,
    required this.question,
    this.inCorrectAnswer,
    required this.correctAnswer,
    this.answers,
  });
}
