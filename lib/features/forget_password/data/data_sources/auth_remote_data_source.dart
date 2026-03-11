import 'package:exams_app/features/forget_password/data/models/forget_password_response.dart';
import 'package:exams_app/features/forget_password/data/models/reset_password_response.dart';
import 'package:exams_app/features/forget_password/data/models/verify_code_response.dart';

abstract class AuthRemoteDataSource {
  Future<ForgetPasswordResponse> forgetPassword(String email);
  Future<VerifyCodeResponse> verifyResetCode(String code);
  Future<ResetPasswordResponse> resetPassword(String email, String newPassword);
}
