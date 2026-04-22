import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/authentication/data/models/forget_password_response.dart';
import 'package:exams_app/features/authentication/data/models/reset_password_response.dart';
import 'package:exams_app/features/authentication/data/models/user_model.dart';
import 'package:exams_app/features/authentication/data/models/verify_code_response.dart';

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

  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(String email);

  Future<BaseResponse<VerifyCodeResponse>> verifyResetCode(String code);

  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
    String email,
    String newPassword,
  );
}
