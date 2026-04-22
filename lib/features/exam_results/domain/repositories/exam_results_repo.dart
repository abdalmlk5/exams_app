import '../../domain/entities/exam_result_entity.dart';

abstract class ExamResultsRepo {
  Future<void> saveExamResult(ExamResultEntity result);
  Future<List<ExamResultEntity>> getExamResults();
}
