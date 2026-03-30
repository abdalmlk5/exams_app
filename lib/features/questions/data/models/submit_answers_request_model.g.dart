// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_answers_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitAnswersRequestModel _$SubmitAnswersRequestModelFromJson(
  Map<String, dynamic> json,
) => SubmitAnswersRequestModel(
  answers: (json['answers'] as List<dynamic>)
      .map((e) => AnswerCheckItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  time: (json['time'] as num).toInt(),
);

Map<String, dynamic> _$SubmitAnswersRequestModelToJson(
  SubmitAnswersRequestModel instance,
) => <String, dynamic>{'answers': instance.answers, 'time': instance.time};
