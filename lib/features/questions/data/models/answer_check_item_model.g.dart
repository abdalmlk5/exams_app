// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_check_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerCheckItemModel _$AnswerCheckItemModelFromJson(
  Map<String, dynamic> json,
) => AnswerCheckItemModel(
  questionId: json['questionId'] as String,
  correct: json['correct'] as String,
);

Map<String, dynamic> _$AnswerCheckItemModelToJson(
  AnswerCheckItemModel instance,
) => <String, dynamic>{
  'questionId': instance.questionId,
  'correct': instance.correct,
};
