// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionResponseModel _$QuestionResponseModelFromJson(
  Map<String, dynamic> json,
) => QuestionResponseModel(
  message: json['message'] as String,
  questions: (json['questions'] as List<dynamic>)
      .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$QuestionResponseModelToJson(
  QuestionResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'questions': instance.questions,
};
