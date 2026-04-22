import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/change_password/api/models/change_password_request.dart';
import 'package:exams_app/features/change_password/domain/repositories/change_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {
  final ChangePasswordRepo _repository;

  ChangePasswordUseCase(this._repository);

  Future<BaseResponse<String>> call(ChangePasswordRequest request) {
    return _repository.changePassword(request);
  }
}
