import 'package:exams_app/features/exams/data/models/exam_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../repository/exams_repo.dart';

@injectable
class GetExamsUseCase {
  final ExamsRepo repo;

  GetExamsUseCase(this.repo);

  Future<BaseResponse<List<ExamModel>>> call({String? subject}) async {
    return await repo.getExams(subject: subject);
  }
}
