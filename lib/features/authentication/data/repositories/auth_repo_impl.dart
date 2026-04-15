import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/config/error_handler/error_handler.dart';
import 'package:exams_app/features/authentication/data/datasources/auth_local_data_source_contract.dart';
import 'package:exams_app/features/authentication/data/datasources/auth_remote_data_source_contract.dart';
import 'package:exams_app/features/authentication/data/models/user_model.dart';
import 'package:exams_app/features/authentication/domain/entities/user_entity.dart';
import 'package:exams_app/features/authentication/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../response/forget_password_models/forget_password_response.dart';
import '../response/forget_password_models/reset_password_response.dart';
import '../response/forget_password_models/verify_code_response.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSourceContract authRemoteDataSourceContract;
  final AuthLocalDataSourceContract authLocalDataSourceContract;

  AuthRepoImpl({
    required this.authRemoteDataSourceContract,
    required this.authLocalDataSourceContract,
  });

  @override
  Future<BaseResponse<UserEntity>> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    final response = await authRemoteDataSourceContract.login(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );

    switch (response) {
      case SuccessBaseResponse<UserModel>():
        return SuccessBaseResponse<UserEntity>(response.data.toEntity());
      case ErrorBaseResponse<UserModel>():
        return ErrorBaseResponse<UserEntity>(response.error);
    }
  }

  @override
  Future<BaseResponse<UserEntity>> register({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
    bool rememberMe = false,
  }) async {
    final response = await authRemoteDataSourceContract.register(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
      rememberMe: rememberMe,
    );

    switch (response) {
      case SuccessBaseResponse<UserModel>():
        return SuccessBaseResponse<UserEntity>(response.data.toEntity());
      case ErrorBaseResponse<UserModel>():
        return ErrorBaseResponse<UserEntity>(response.error);
    }
  }

  @override
  Future<BaseResponse<void>> logout() async {
    try {
      await authRemoteDataSourceContract.logout();
      return SuccessBaseResponse<void>(null);
    } catch (e) {
      return ErrorBaseResponse<void>(ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<UserEntity>> getUserData() async {
    final response = await authRemoteDataSourceContract.getUserData();

    switch (response) {
      case SuccessBaseResponse<UserModel>():
        return SuccessBaseResponse<UserEntity>(response.data.toEntity());
      case ErrorBaseResponse<UserModel>():
        return ErrorBaseResponse<UserEntity>(response.error);
    }
  }


//TODO: Use Switch case to check the errorBaseResponse and successBaseResponse that come from the remote data source
  @override
  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(
    String email,
  ) async {
    try {
      final response = await authRemoteDataSourceContract.forgetPassword(email);
      return SuccessBaseResponse(response);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<VerifyCodeResponse>> verifyCode(String code) async {
    try {
      final response = await authRemoteDataSourceContract.verifyResetCode(code);
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
      final response = await authRemoteDataSourceContract.resetPassword(
        email,
        newPassword,
      );
      return SuccessBaseResponse(response);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }

  @override
  Future<bool> isRemembered() async {
    return await authLocalDataSourceContract.getRememberMe();
  }
}
