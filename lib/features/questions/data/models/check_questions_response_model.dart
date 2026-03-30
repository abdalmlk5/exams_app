import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/check_questions_response_entity.dart';
import 'question_result_model.dart';

part 'check_questions_response_model.g.dart';

@JsonSerializable()
class CheckQuestionsResponseModel {
  final String message;
  final int correct;
  final int wrong;
  final String total;
  @JsonKey(name: 'WrongQuestions')
  final List<QuestionResultModel> wrongQuestions;
  final List<QuestionResultModel> correctQuestions;

  CheckQuestionsResponseModel({
    required this.message,
    required this.correct,
    required this.wrong,
    required this.total,
    required this.wrongQuestions,
    required this.correctQuestions,
  });

  factory CheckQuestionsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CheckQuestionsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckQuestionsResponseModelToJson(this);

  CheckQuestionsResponseEntity toEntity() {
    return CheckQuestionsResponseEntity(
      message: message,
      correct: correct,
      wrong: wrong,
      total: total,
      wrongQuestions: wrongQuestions.map((i) => i.toEntity()).toList(),
      correctQuestions: correctQuestions.map((i) => i.toEntity()).toList(),
    );
  }
}
