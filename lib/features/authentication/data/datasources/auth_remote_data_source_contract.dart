import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/authentication/data/models/user_model.dart';

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

}
