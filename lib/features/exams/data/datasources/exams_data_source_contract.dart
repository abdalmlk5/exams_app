import 'package:exams_app/features/exams/data/models/exams_response.dart';

import '../../../../config/base_response/base_response.dart';

abstract class ExamsDataSourceContract {
  Future<BaseResponse<ExamsResponse>> getExams({required String token});
}
