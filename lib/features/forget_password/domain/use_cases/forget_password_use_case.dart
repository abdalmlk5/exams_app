import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/forget_password/data/models/forget_password_response.dart';
import 'package:exams_app/features/forget_password/domain/repo/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordUseCase {
  final ForgetPasswordRepo repository;

  ForgetPasswordUseCase(this.repository);

  Future<BaseResponse<ForgetPasswordResponse>> call(String email) {
    return repository.forgetPassword(email);
  }
}
