import 'package:equatable/equatable.dart';

class ExamEntity extends Equatable {
  final String? id;
  final String? title;
  final int? duration;
  final String? subject;
  final int? numberOfQuestions;
  final bool? active;
  final String? createdAt;

  const ExamEntity({
    this.id,
    this.title,
    this.duration,
    this.subject,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    duration,
    subject,
    numberOfQuestions,
    active,
    createdAt,
  ];
}
