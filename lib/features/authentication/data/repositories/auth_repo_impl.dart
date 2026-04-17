import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/config/error_handler/error_handler.dart';
import 'package:exams_app/features/authentication/data/datasources/auth_local_data_source_contract.dart';
import 'package:exams_app/features/authentication/data/datasources/auth_remote_data_source_contract.dart';
import 'package:exams_app/features/authentication/data/models/user_model.dart';
import 'package:exams_app/features/authentication/domain/entities/user_entity.dart';
import 'package:exams_app/features/authentication/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';


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
      await authLocalDataSourceContract.deleteToken();
      await authLocalDataSourceContract.deleteRememberMe();
      return SuccessBaseResponse<void>(null);
    } catch (e) {
      // Even if remote logout fails, we should clear local data to force logout locally
      await authLocalDataSourceContract.deleteToken();
      await authLocalDataSourceContract.deleteRememberMe();
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

  @override
  Future<bool> isRemembered() async {
    return await authLocalDataSourceContract.getRememberMe();
  }
}
