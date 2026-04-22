import 'package:exams_app/features/exam_results/domain/entities/exam_result_entity.dart';

sealed class ExamResultsEvent {}

class GetExamResultsEvent extends ExamResultsEvent {}


class SaveExamResultEvent extends ExamResultsEvent {
  final ExamResultEntity result;
  SaveExamResultEvent(this.result);
}
