import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/config/error_handler/error_handler.dart';
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
  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(String email) async {
    try {
      final response = await _apiClient.forgetPassword(email);
      return SuccessBaseResponse(response);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<VerifyCodeResponse>> verifyResetCode(String code) async {
    try {
      final response = await _apiClient.verifyResetCode(code);
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
      final response = await _apiClient.resetPassword(email, newPassword);
      return SuccessBaseResponse(response);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }
}
