// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_questions_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckQuestionsResponseModel _$CheckQuestionsResponseModelFromJson(
  Map<String, dynamic> json,
) => CheckQuestionsResponseModel(
  message: json['message'] as String,
  correct: (json['correct'] as num).toInt(),
  wrong: (json['wrong'] as num).toInt(),
  total: json['total'] as String,
  wrongQuestions: (json['WrongQuestions'] as List<dynamic>)
      .map((e) => QuestionResultModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  correctQuestions: (json['correctQuestions'] as List<dynamic>)
      .map((e) => QuestionResultModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CheckQuestionsResponseModelToJson(
  CheckQuestionsResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'correct': instance.correct,
  'wrong': instance.wrong,
  'total': instance.total,
  'WrongQuestions': instance.wrongQuestions,
  'correctQuestions': instance.correctQuestions,
};
