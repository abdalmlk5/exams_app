import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/config/error_handler/error_handler.dart';
import 'package:exams_app/features/authentication/api/api_client/auth_api_client.dart';
import 'package:exams_app/features/authentication/data/datasources/auth_local_data_source_contract.dart';
import 'package:exams_app/features/authentication/data/datasources/auth_remote_data_source_contract.dart';
import 'package:exams_app/features/authentication/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/dummy_data/dummy_data.dart';
import '../models/forget_password_models/forget_password_response.dart';
import '../models/forget_password_models/reset_password_response.dart';
import '../models/forget_password_models/verify_code_response.dart';

@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSourceContract {
  final AuthApiClient authApiClient;
  final AuthLocalDataSourceContract localDataSource;

  AuthRemoteDataSourceImpl({
    required this.authApiClient,
    required this.localDataSource,
  });

  @override
  Future<BaseResponse<UserModel>> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      // final response = await authApiClient.login({
      //   'email': email,
      //   'password': password,
      // });
      final response = DummyData.user;
      final token = 'dummy_token';

      await localDataSource.saveToken(token);
      await localDataSource.saveRememberMe(rememberMe);

      return SuccessBaseResponse<UserModel>(response);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<UserModel>> register({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
    bool rememberMe = false,
  }) async {
    try {
      // final response = await authApiClient.register({
      //   'username': username,
      //   'firstName': firstName,
      //   'lastName': lastName,
      //   'email': email,
      //   'password': password,
      //   'rePassword': rePassword,
      //   'phone': phone,
      // });
      final response = DummyData.user;
      final token = 'dummy_token';

      await localDataSource.saveToken(token);
      await localDataSource.saveRememberMe(rememberMe);

      return SuccessBaseResponse<UserModel>(response);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }

  @override
  Future<void> logout() async {
    try {
      final token = await localDataSource.getToken();
      if (token != null) {
        try {
          // await authApiClient.logout();
        } catch (_) {
          // Ignore API error during logout
        }
      }
    } finally {
      await Future.wait([
        localDataSource.deleteToken(),
        localDataSource.deleteRememberMe(),
      ]);
    }
  }

  @override
  Future<BaseResponse<UserModel>> getUserData() async {
    try {
      // final response = await authApiClient.getUserData();
      final response = DummyData.user;

      return SuccessBaseResponse<UserModel>(response);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(String email) async {
    // return authApiClient.forgetPassword({"email": email});
    return DummyData.forgetPasswordResponse;
  }

  @override
  Future<VerifyCodeResponse> verifyResetCode(String code) async {
    // return authApiClient.verifyResetCode({"resetCode": code});
    return DummyData.verifyCodeResponse;
  }

  @override
  Future<ResetPasswordResponse> resetPassword(
    String email,
    String newPassword,
  ) async {
    // return authApiClient.resetPassword({
    //   "email": email,
    //   "newPassword": newPassword,
    // });
    return DummyData.resetPasswordResponse;
  }
}
