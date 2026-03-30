import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/exam_entity.dart';

part 'exam_model.g.dart';

@JsonSerializable()
class ExamModel {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final int duration;
  final int numberOfQuestions;
  final String? subject;
  final bool? active;
  final String? createdAt;

  ExamModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.numberOfQuestions,
    this.subject,
    this.active,
    this.createdAt,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) =>
      _$ExamModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamModelToJson(this);

  ExamEntity toEntity() {
    return ExamEntity(
      id: id,
      title: title,
      duration: duration,
      numberOfQuestions: numberOfQuestions,
      subject: subject,
      active: active,
      createdAt: createdAt,
    );
  }
}