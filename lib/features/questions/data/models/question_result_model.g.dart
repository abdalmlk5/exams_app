// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionResultModel _$QuestionResultModelFromJson(Map<String, dynamic> json) =>
    QuestionResultModel(
      qid: json['QID'] as String,
      question: json['Question'] as String,
      inCorrectAnswer: json['inCorrectAnswer'] as String?,
      correctAnswer: json['correctAnswer'] as String,
      answers: json['answers'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$QuestionResultModelToJson(
  QuestionResultModel instance,
) => <String, dynamic>{
  'QID': instance.qid,
  'Question': instance.question,
  'inCorrectAnswer': instance.inCorrectAnswer,
  'correctAnswer': instance.correctAnswer,
  'answers': instance.answers,
};
