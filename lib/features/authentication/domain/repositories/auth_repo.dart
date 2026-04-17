import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/authentication/domain/entities/user_entity.dart';


abstract class AuthRepo {
  Future<BaseResponse<UserEntity>> login({
    required String email,
    required String password,
    bool rememberMe = false,
  });
  Future<BaseResponse<UserEntity>> register({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
    bool rememberMe = false,
  });

  Future<BaseResponse<void>> logout();
  Future<BaseResponse<UserEntity>> getUserData();

  Future<bool> isRemembered();
}
