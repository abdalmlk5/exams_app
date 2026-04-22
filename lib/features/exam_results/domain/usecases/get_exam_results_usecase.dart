import 'package:injectable/injectable.dart';
import '../entities/exam_result_entity.dart';
import '../repositories/exam_results_repo.dart';

@injectable
class GetExamResultsUseCase {
  final ExamResultsRepo repository;

  GetExamResultsUseCase(this.repository);

  Future<List<ExamResultEntity>> call() async {
    return await repository.getExamResults();
  }
}
