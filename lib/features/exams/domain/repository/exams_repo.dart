import 'package:exams_app/features/exams/data/models/exam_model.dart';
import '../../../../config/base_response/base_response.dart';

abstract class ExamsRepo {
  Future<BaseResponse<List<ExamModel>>> getExams(String token);
}
