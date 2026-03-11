import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/config/error_handler/error_handler.dart';
import 'package:exams_app/features/authentication/data/datasources/auth_remote_data_source_contract.dart';
import 'package:exams_app/features/authentication/data/models/user_model.dart';
import 'package:exams_app/features/authentication/domain/entities/user_entity.dart';
import 'package:exams_app/features/authentication/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSourceContract authRemoteDataSourceContract;

  AuthRepoImpl({required this.authRemoteDataSourceContract});
  @override
  Future<BaseResponse<UserEntity>> login({
    required String email,
    required String password,
  }) async {
    final response = await authRemoteDataSourceContract.login(
      email: email,
      password: password,
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
  }) async {
    final response = await authRemoteDataSourceContract.register(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
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
}
