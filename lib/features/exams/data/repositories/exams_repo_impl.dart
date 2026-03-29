import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/exams/data/models/exam_model.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/exams_repo.dart';
import '../datasources/exams_data_source_contract.dart';
import '../models/exams_response.dart';

@Injectable(as: ExamsRepo)
class ExamsRepoImpl extends ExamsRepo {
  final ExamsDataSourceContract dataSource;

  ExamsRepoImpl(this.dataSource);

  @override
  Future<BaseResponse<List<ExamModel>>> getExams(
    String token, {
    String? subject,
  }) async {
    final response = await dataSource.getExams(token: token, subject: subject);

    switch (response) {
      case SuccessBaseResponse():
        return SuccessBaseResponse<List<ExamModel>>(response.data.exams ?? []);
      case ErrorBaseResponse<ExamsResponse>():
        return ErrorBaseResponse<List<ExamModel>>(response.errorMessage);
    }
  }
}
