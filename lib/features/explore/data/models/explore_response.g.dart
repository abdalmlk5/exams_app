// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExploreResponse _$ExploreResponseFromJson(Map<String, dynamic> json) =>
    ExploreResponse(
      message: json['message'] as String?,
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      subjects: (json['subjects'] as List<dynamic>?)
          ?.map((e) => SubjectModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExploreResponseToJson(ExploreResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'metadata': instance.metadata,
      'subjects': instance.subjects,
    };
