import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/authentication/domain/entities/user_entity.dart';
import 'package:exams_app/features/authentication/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUsecase {
  final AuthRepo authRepoContract;

  LoginUsecase({required this.authRepoContract});

  Future<BaseResponse<UserEntity>> call({
    required String email,
    required final String password,
    bool rememberMe = false,
  }) async {
    return await authRepoContract.login(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
  }
}
