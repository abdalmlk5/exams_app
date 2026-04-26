import 'package:exams_app/features/explore/domain/entities/subject_entity.dart';
import '../../../../config/base_response/base_response.dart';

abstract interface class ExploreRepo {
  Future<BaseResponse<List<SubjectEntity>>> getSubjects();
}
