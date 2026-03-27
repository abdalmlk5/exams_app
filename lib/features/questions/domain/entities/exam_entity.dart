class ExamEntity {
  final String id;
  final String title;
  final int duration;
  final int numberOfQuestions;
  final String? subject;
  final bool? active;
  final String? createdAt;

  ExamEntity({
    required this.id,
    required this.title,
    required this.duration,
    required this.numberOfQuestions,
    this.subject,
    this.active,
    this.createdAt,
  });
}
