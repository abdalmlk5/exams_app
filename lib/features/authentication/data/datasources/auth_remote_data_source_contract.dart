import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/authentication/data/models/user_model.dart';

import '../response/forget_password_models/forget_password_response.dart';
import '../response/forget_password_models/reset_password_response.dart';
import '../response/forget_password_models/verify_code_response.dart';

abstract class AuthRemoteDataSourceContract {
  Future<BaseResponse<UserModel>> login({
    required String email,
    required String password,
    bool rememberMe = false,
  });
  Future<BaseResponse<UserModel>> register({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
    bool rememberMe = false,
  });

  Future<void> logout();
  Future<BaseResponse<UserModel>> getUserData();

  Future<ForgetPasswordResponse> forgetPassword(String email);
  Future<VerifyCodeResponse> verifyResetCode(String code);
  Future<ResetPasswordResponse> resetPassword(String email, String newPassword);
}
