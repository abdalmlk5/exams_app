import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/authentication/data/models/forget_password_response.dart';
import 'package:exams_app/features/authentication/data/models/reset_password_response.dart';
import 'package:exams_app/features/authentication/data/models/verify_code_response.dart';

abstract interface class ForgetPasswordRepo {
  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(String email);
  Future<BaseResponse<VerifyCodeResponse>> verifyCode(String code);
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
    String email,
    String newPassword,
  );
}
