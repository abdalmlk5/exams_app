import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/config/error_handler/error_handler.dart';
import 'package:exams_app/features/forget_password/data/data_sources/auth_remote_data_source.dart';
import 'package:exams_app/features/forget_password/data/models/forget_password_response.dart';
import 'package:exams_app/features/forget_password/data/models/reset_password_response.dart';
import 'package:exams_app/features/forget_password/data/models/verify_code_response.dart';
import 'package:exams_app/features/forget_password/domain/repo/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgetPasswordRepo)
class ForgetPasswordRepoImpl implements ForgetPasswordRepo {
  final AuthRemoteDataSource _remoteDataSource;

  ForgetPasswordRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(
    String email,
  ) async {
    try {
      final response = await _remoteDataSource.forgetPassword(email);
      return SuccessBaseResponse(response);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<VerifyCodeResponse>> verifyCode(String code) async {
    try {
      final response = await _remoteDataSource.verifyResetCode(code);
      return SuccessBaseResponse(response);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
    String email,
    String newPassword,
  ) async {
    try {
      final response = await _remoteDataSource.resetPassword(
        email,
        newPassword,
      );
      return SuccessBaseResponse(response);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }
}
