import 'package:exams_app/features/exams/domain/entities/exam_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../domain/repository/exams_repo.dart';
import '../datasources/exams_data_source_contract.dart';
import '../models/exams_response.dart';

@Injectable(as: ExamsRepo)
class ExamsRepoImpl implements ExamsRepo {
  final ExamsDataSourceContract dataSource;

  ExamsRepoImpl(this.dataSource);

  @override
  Future<BaseResponse<List<ExamEntity>>> getExams({String? subject}) async {
    final response = await dataSource.getExams(subject: subject);

    switch (response) {
      case SuccessBaseResponse():
        final exams =
            response.data.exams?.map((model) => model.toEntity()).toList() ??
            [];
        return SuccessBaseResponse<List<ExamEntity>>(exams);
      case ErrorBaseResponse<ExamsResponse>():
        return ErrorBaseResponse<List<ExamEntity>>(response.errorMessage);
    }
  }
}
