import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/explore/data/datasources/explore_data_source_contract.dart';
import 'package:exams_app/features/explore/domain/entities/subject_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/explore_repo.dart';
import '../models/explore_response.dart';

@Injectable(as: ExploreRepo)
class ExploreRepoImpl implements ExploreRepo {
  final ExploreDataSourceContract dataSource;

  ExploreRepoImpl(this.dataSource);

  @override
  Future<BaseResponse<List<SubjectEntity>>> getSubjects() async {
    final response = await dataSource.getSubjects();

    switch (response) {
      case SuccessBaseResponse():
        final subjects =
            response.data.subjects?.map((model) => model.toEntity()).toList() ??
            [];
        return SuccessBaseResponse<List<SubjectEntity>>(subjects);
      case ErrorBaseResponse<ExploreResponse>():
        return ErrorBaseResponse<List<SubjectEntity>>(response.errorMessage);
    }
  }
}
