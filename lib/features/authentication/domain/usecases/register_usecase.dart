import 'package:injectable/injectable.dart';
import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/authentication/domain/entities/user_entity.dart';
import 'package:exams_app/features/authentication/domain/repositories/auth_repo.dart';

@injectable
class RegisterUsecase {
  final AuthRepo authRepoContract;

  RegisterUsecase({required this.authRepoContract});

  Future<BaseResponse<UserEntity>> call({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
    required bool rememberMe,
  }) async {
    return authRepoContract.register(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
      rememberMe: rememberMe,
    );
  }
}
