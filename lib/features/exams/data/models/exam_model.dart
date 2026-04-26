import 'package:exams_app/features/exams/domain/entities/exam_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exam_model.g.dart';

@JsonSerializable()
class ExamModel {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "duration")
  final int? duration;
  @JsonKey(name: "subject")
  final String? subject;
  @JsonKey(name: "numberOfQuestions")
  final int? numberOfQuestions;
  @JsonKey(name: "active")
  final bool? active;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  ExamModel({
    this.id,
    this.title,
    this.duration,
    this.subject,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return _$ExamModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExamModelToJson(this);
  }

  ExamEntity toEntity() {
    return ExamEntity(
      id: id,
      title: title,
      duration: duration,
      subject: subject,
      numberOfQuestions: numberOfQuestions,
      active: active,
      createdAt: createdAt,
    );
  }
}
