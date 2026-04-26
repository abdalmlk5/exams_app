import 'package:exams_app/features/exams/domain/entities/exam_entity.dart';
import '../../../../config/base_response/base_response.dart';

abstract interface class ExamsRepo {
  Future<BaseResponse<List<ExamEntity>>> getExams({String? subject});
}
