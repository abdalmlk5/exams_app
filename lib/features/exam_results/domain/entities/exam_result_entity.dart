class ExamResultEntity {
  final int? id;
  final String examId;
  final String title;
  final String subject;
  final int duration;
  final int numberOfQuestions;
  final int correctAnswers;
  final int timeTakenMinutes;
  final String createdAt;
  final List<DetailedAnswerEntity> detailedAnswers;

  ExamResultEntity({
    this.id,
    required this.examId,
    required this.title,
    required this.subject,
    required this.duration,
    required this.numberOfQuestions,
    required this.correctAnswers,
    required this.timeTakenMinutes,
    required this.createdAt,
    required this.detailedAnswers,
  });
}

class DetailedAnswerEntity {
  final String questionText;
  final List<OptionEntity> options;
  final String correctAnswerKey;
  final String userSelectedKey;
  final String type;

  DetailedAnswerEntity({
    required this.questionText,
    required this.options,
    required this.correctAnswerKey,
    required this.userSelectedKey,
    required this.type,
  });
}

class OptionEntity {
  final String text;
  final String key;

  OptionEntity({required this.text, required this.key});
}
