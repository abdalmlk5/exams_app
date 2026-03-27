import 'package:json_annotation/json_annotation.dart';
import '../models/question_model.dart';

part 'question_response_model.g.dart';

@JsonSerializable()
class QuestionResponseModel {
  final String message;
  final List<QuestionModel> questions;

  QuestionResponseModel({required this.message, required this.questions});

  factory QuestionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionResponseModelToJson(this);
}