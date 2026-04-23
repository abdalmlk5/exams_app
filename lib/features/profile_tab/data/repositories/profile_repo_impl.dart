import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/profile_tab/data/data_sources/profile_remote_data_source.dart';
import 'package:exams_app/features/profile_tab/domain/entities/profile_user_entity.dart';
import 'package:exams_app/features/profile_tab/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<ProfileUserEntity>> getProfileData() async {
    try {
      final response = await _remoteDataSource.getProfileData();
      return SuccessBaseResponse<ProfileUserEntity>(
        response.user!.toProfileEntity(),
      );
    } catch (e) {
      return ErrorBaseResponse<ProfileUserEntity>(e.toString());
    }
  }

  @override
  Future<BaseResponse<ProfileUserEntity>> updateProfile(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _remoteDataSource.updateProfile(body);
      return SuccessBaseResponse<ProfileUserEntity>(
        response.user!.toProfileEntity(),
      );
    } catch (e) {
      return ErrorBaseResponse<ProfileUserEntity>(e.toString());
    }
  }
}
