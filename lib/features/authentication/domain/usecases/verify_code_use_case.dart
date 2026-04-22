import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/authentication/data/models/verify_code_response.dart';
import 'package:exams_app/features/authentication/domain/repositories/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyCodeUseCase {
  final ForgetPasswordRepo repository;

  VerifyCodeUseCase(this.repository);

  Future<BaseResponse<VerifyCodeResponse>> call(String code) {
    return repository.verifyCode(code);
  }
}
