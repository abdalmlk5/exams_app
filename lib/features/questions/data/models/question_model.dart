import 'package:json_annotation/json_annotation.dart';
import 'package:exams_app/features/explore/data/models/subject_model.dart';
import '../../domain/entities/question_entity.dart';
import 'exam_model.dart';
import 'answer_model.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  @JsonKey(name: '_id')
  final String id;
  final String question;
  final List<AnswerModel> answers;
  final String type;
  final String correct;
  final SubjectModel? subject;
  final ExamModel? exam;
  final String? createdAt;

  QuestionModel({
    required this.id,
    required this.question,
    required this.answers,
    required this.type,
    required this.correct,
    this.subject,
    this.exam,
    this.createdAt,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);

  QuestionEntity toEntity() {
    return QuestionEntity(
      id: id,
      question: question,
      answers: answers.map((e) => e.toEntity()).toList(),
      type: type,
      correct: correct,
      subject: subject?.name,
      exam: exam?.toEntity(),
      createdAt: createdAt,
    );
  }
}