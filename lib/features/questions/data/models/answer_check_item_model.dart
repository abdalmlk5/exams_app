import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/answer_check_item_entity.dart';

part 'answer_check_item_model.g.dart';

@JsonSerializable()
class AnswerCheckItemModel {
  final String questionId;
  final String correct;

  AnswerCheckItemModel({required this.questionId, required this.correct});

  factory AnswerCheckItemModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerCheckItemModelFromJson(json);

  factory AnswerCheckItemModel.fromEntity(AnswerCheckItemEntity entity) {
    return AnswerCheckItemModel(
      questionId: entity.questionId,
      correct: entity.correct,
    );
  }

  Map<String, dynamic> toJson() => _$AnswerCheckItemModelToJson(this);

  AnswerCheckItemEntity toEntity() {
    return AnswerCheckItemEntity(questionId: questionId, correct: correct);
  }
}
