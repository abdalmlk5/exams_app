import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/authentication/domain/entities/auth_user_entity.dart';
import 'package:exams_app/features/authentication/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserDataUsecase {
  final AuthRepo authRepoContract;

  GetUserDataUsecase({required this.authRepoContract});

  Future<BaseResponse<AuthUserEntity>> call() async {
    return await authRepoContract.getUserData();
  }
}
