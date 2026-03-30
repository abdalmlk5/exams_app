import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/question_result_entity.dart';

part 'question_result_model.g.dart';

@JsonSerializable()
class QuestionResultModel {
  @JsonKey(name: 'QID')
  final String qid;
  @JsonKey(name: 'Question')
  final String question;
  final String? inCorrectAnswer;
  final String correctAnswer;
  final Map<String, dynamic>? answers;

  QuestionResultModel({
    required this.qid,
    required this.question,
    this.inCorrectAnswer,
    required this.correctAnswer,
    this.answers,
  });

  factory QuestionResultModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionResultModelToJson(this);

  QuestionResultEntity toEntity() {
    return QuestionResultEntity(
      qid: qid,
      question: question,
      inCorrectAnswer: inCorrectAnswer,
      correctAnswer: correctAnswer,
      answers: answers,
    );
  }
}
