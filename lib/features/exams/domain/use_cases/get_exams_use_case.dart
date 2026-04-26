import 'package:exams_app/features/exams/domain/entities/exam_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../repository/exams_repo.dart';

@injectable
class GetExamsUseCase {
  final ExamsRepo repo;

  GetExamsUseCase(this.repo);

  Future<BaseResponse<List<ExamEntity>>> call({String? subject}) {
    return repo.getExams(subject: subject);
  }
}
