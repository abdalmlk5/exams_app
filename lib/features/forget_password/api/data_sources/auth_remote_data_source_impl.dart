import 'package:exams_app/features/forget_password/api/api_client/auth_api_client.dart';
import 'package:exams_app/features/forget_password/data/data_sources/auth_remote_data_source.dart';
import 'package:exams_app/features/forget_password/data/models/forget_password_response.dart';
import 'package:exams_app/features/forget_password/data/models/reset_password_response.dart';
import 'package:exams_app/features/forget_password/data/models/verify_code_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ForgetPasswordResponse> forgetPassword(String email) {
    return _apiClient.forgetPassword(email);
  }

  @override
  Future<VerifyCodeResponse> verifyResetCode(String code) {
    return _apiClient.verifyResetCode(code);
  }

  @override
  Future<ResetPasswordResponse> resetPassword(
    String email,
    String newPassword,
  ) {
    return _apiClient.resetPassword(email, newPassword);
  }
}
