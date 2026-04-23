import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/explore/data/datasources/explore_data_source_contract.dart';
import 'package:exams_app/features/explore/data/models/subject_model.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/explore_repo.dart';
import '../models/explore_response.dart';

@Injectable(as: ExploreRepo)
class ExploreRepoImpl extends ExploreRepo {
  final ExploreDataSourceContract dataSource;

  ExploreRepoImpl(this.dataSource);

  @override
  Future<BaseResponse<List<SubjectModel>>> getSubjects() async {
    final response = await dataSource.getSubjects();

    switch (response) {
      case SuccessBaseResponse():
        return SuccessBaseResponse<List<SubjectModel>>(
          response.data.subjects ?? [],
        );
      case ErrorBaseResponse<ExploreResponse>():
        return ErrorBaseResponse<List<SubjectModel>>(response.errorMessage);
    }
  }
}
