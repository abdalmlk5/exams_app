import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/authentication/data/response/forget_password_models/forget_password_response.dart';
import 'package:injectable/injectable.dart';

import '../repositories/auth_repo.dart';

@injectable
class ForgetPasswordUseCase {
  final AuthRepo repository;

  ForgetPasswordUseCase(this.repository);

  Future<BaseResponse<ForgetPasswordResponse>> call(String email) {
    return repository.forgetPassword(email);
  }
}
