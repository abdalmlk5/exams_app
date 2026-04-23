import 'package:exams_app/features/explore/data/models/explore_response.dart';

import '../../../../config/base_response/base_response.dart';

abstract class ExploreDataSourceContract {
  Future<BaseResponse<ExploreResponse>> getSubjects();
}
