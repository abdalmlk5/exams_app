import 'package:injectable/injectable.dart';
import '../entities/exam_result_entity.dart';
import '../repositories/exam_results_repo.dart';

@injectable
class SaveExamResultUseCase {
  final ExamResultsRepo repository;

  SaveExamResultUseCase(this.repository);

  Future<void> call(ExamResultEntity result) async {
    return await repository.saveExamResult(result);
  }
}
