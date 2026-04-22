import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../entities/profile_user_entity.dart';
import '../repositories/profile_repo.dart';

@injectable
class GetProfileUseCase {
  final ProfileRepo repo;

  GetProfileUseCase(this.repo);

  Future<BaseResponse<ProfileUserEntity>> call({String? token}) async {
    return await repo.getProfileData(token: token);
  }
}
