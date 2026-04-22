import '../models/exam_result_model.dart';

abstract class ExamResultsLocalDataSourceContract {
  Future<void> saveExamResult(ExamResultModel result);
  Future<List<ExamResultModel>> getExamResults();
}
