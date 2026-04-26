import 'package:exams_app/features/explore/domain/entities/subject_entity.dart';
import 'package:exams_app/features/explore/domain/repository/explore_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';

@injectable
class GetSubjectsUseCase {
  final ExploreRepo repo;

  GetSubjectsUseCase(this.repo);

  Future<BaseResponse<List<SubjectEntity>>> call() {
    return repo.getSubjects();
  }
}
