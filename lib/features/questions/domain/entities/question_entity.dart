import 'answer_entity.dart';
import 'exam_entity.dart';

class QuestionEntity {
  final String id;
  final String question;
  final List<AnswerEntity> answers;
  final String type;
  final String correct;
  final String? subject;
  final ExamEntity? exam;
  final String? createdAt;

  QuestionEntity({
    required this.id,
    required this.question,
    required this.answers,
    required this.type,
    required this.correct,
    this.subject,
    this.exam,
    this.createdAt,
  });
}
