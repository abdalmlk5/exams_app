import 'package:exams_app/features/profile_tab/domain/entities/profile_user_entity.dart';

import '../../../../config/base_response/base_response.dart';

abstract class ProfileRepo {
  Future<BaseResponse<ProfileUserEntity>> getProfileData();
  Future<BaseResponse<ProfileUserEntity>> updateProfile(
    Map<String, dynamic> body,
  );
}
