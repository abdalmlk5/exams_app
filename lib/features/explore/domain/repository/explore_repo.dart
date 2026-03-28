import 'package:exams_app/features/explore/data/models/subject_model.dart';

import '../../../../config/base_response/base_response.dart';

abstract class ExploreRepo {
  Future<BaseResponse<List<SubjectModel>>> getSubjects(String token);
}
