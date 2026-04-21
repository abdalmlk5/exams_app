import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/authentication/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUsecase {
  final AuthRepo authRepoContract;

  LogoutUsecase({required this.authRepoContract});

  Future<BaseResponse<void>> call() async {
    return  authRepoContract.logout();
  }
}
