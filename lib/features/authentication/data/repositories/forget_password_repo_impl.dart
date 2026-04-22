import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/authentication/data/datasources/auth_remote_data_source_contract.dart';
import 'package:exams_app/features/authentication/data/models/forget_password_response.dart';
import 'package:exams_app/features/authentication/data/models/reset_password_response.dart';
import 'package:exams_app/features/authentication/data/models/verify_code_response.dart';
import 'package:exams_app/features/authentication/domain/repositories/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgetPasswordRepo)
class ForgetPasswordRepoImpl implements ForgetPasswordRepo {
  final AuthRemoteDataSourceContract _remoteDataSource;

  ForgetPasswordRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(
    String email,
  ) {
    return _remoteDataSource.forgetPassword(email);
  }

  @override
  Future<BaseResponse<VerifyCodeResponse>> verifyCode(String code) {
    return _remoteDataSource.verifyResetCode(code);
  }

  @override
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
    String email,
    String newPassword,
  ) {
    return _remoteDataSource.resetPassword(email, newPassword);
  }
}
