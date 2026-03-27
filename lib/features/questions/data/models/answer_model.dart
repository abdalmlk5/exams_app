import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/answer_entity.dart';

part 'answer_model.g.dart';

@JsonSerializable()
class AnswerModel {
  final String answer;
  final String key;

  AnswerModel({required this.answer, required this.key});

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerModelToJson(this);

  AnswerEntity toEntity() => AnswerEntity(answer: answer, key: key);
}