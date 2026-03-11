import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/forget_password/data/models/reset_password_response.dart';
import 'package:exams_app/features/forget_password/domain/repo/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  final ForgetPasswordRepo repository;

  ResetPasswordUseCase(this.repository);

  Future<BaseResponse<ResetPasswordResponse>> call(
    String email,
    String newPassword,
  ) {
    return repository.resetPassword(email, newPassword);
  }
}
