import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/profile_tab/domain/entities/profile_user_entity.dart';
import 'package:exams_app/features/profile_tab/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProfileUseCase {
  final ProfileRepo _repository;

  UpdateProfileUseCase(this._repository);

  Future<BaseResponse<ProfileUserEntity>> call(
    Map<String, dynamic> body,
  ) async {
    return await _repository.updateProfile(body);
  }
}
