import 'package:injectable/injectable.dart';
import '../../domain/entities/exam_result_entity.dart';
import '../../domain/repositories/exam_results_repo.dart';
import '../datasources/exam_results_local_datasource_contract.dart';
import '../models/exam_result_model.dart';

@Injectable(as: ExamResultsRepo)
class ExamResultsRepoImpl implements ExamResultsRepo {
  final ExamResultsLocalDataSourceContract localDataSource;

  ExamResultsRepoImpl(this.localDataSource);

  @override
  Future<void> saveExamResult(ExamResultEntity result) async {
    await localDataSource.saveExamResult(ExamResultModel.fromEntity(result));
  }

  @override
  Future<List<ExamResultEntity>> getExamResults() async {
    final models = await localDataSource.getExamResults();
    return models.map((model) => model.toEntity()).toList();
  }
}
