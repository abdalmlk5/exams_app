import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/submit_answers_request_entity.dart';
import 'answer_check_item_model.dart';

part 'submit_answers_request_model.g.dart';

@JsonSerializable()
class SubmitAnswersRequestModel {
  final List<AnswerCheckItemModel> answers;
  final int time;

  SubmitAnswersRequestModel({required this.answers, required this.time});

  factory SubmitAnswersRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitAnswersRequestModelFromJson(json);

  factory SubmitAnswersRequestModel.fromEntity(
    SubmitAnswersRequestEntity entity,
  ) {
    return SubmitAnswersRequestModel(
      answers: entity.answers.map((e) => AnswerCheckItemModel.fromEntity(e)).toList(),
      time: entity.time,
    );
  }

  Map<String, dynamic> toJson() => _$SubmitAnswersRequestModelToJson(this);

  SubmitAnswersRequestEntity toEntity() {
    return SubmitAnswersRequestEntity(
      answers: answers.map((i) => i.toEntity()).toList(),
      time: time,
    );
  }
}
