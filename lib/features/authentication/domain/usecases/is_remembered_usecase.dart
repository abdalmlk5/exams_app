import 'package:exams_app/features/authentication/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class IsRememberedUsecase {
  final AuthRepo authRepoContract;

  IsRememberedUsecase({required this.authRepoContract});

  Future<bool> call() async {
    return  authRepoContract.isRemembered();
  }
}
