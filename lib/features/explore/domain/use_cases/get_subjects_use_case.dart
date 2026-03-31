import 'package:exams_app/features/explore/domain/repository/explore_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../data/models/subject_model.dart';

@injectable
class GetSubjectsUseCase {
  final ExploreRepo repo;

  GetSubjectsUseCase(this.repo);

  Future<BaseResponse<List<SubjectModel>>> call(String token) async {
    return await repo.getSubjects(token);
  }
}
