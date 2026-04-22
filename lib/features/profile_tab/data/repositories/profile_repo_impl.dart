import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/core/models/user_model.dart';
import 'package:exams_app/features/profile_tab/domain/entities/profile_user_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/profile_repo.dart';
import '../data_sources/profile_remote_data_source.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl extends ProfileRepo {
  final ProfileRemoteDataSourceContract dataSource;

  ProfileRepoImpl(this.dataSource);

  @override
  Future<BaseResponse<ProfileUserEntity>> getProfileData({
    String? token,
  }) async {
    final BaseResponse<UserModel> response = await dataSource.getProfileData(
      token: token,
    );
    switch (response) {
      case SuccessBaseResponse<UserModel>():
        return SuccessBaseResponse<ProfileUserEntity>(
          response.data.toProfileEntity(),
        );
      case ErrorBaseResponse<UserModel>():
        return ErrorBaseResponse<ProfileUserEntity>(response.errorMessage);
    }
  }
}
