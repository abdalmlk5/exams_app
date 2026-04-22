import 'package:exams_app/core/models/user_model.dart';

import '../../../../config/base_response/base_response.dart';

abstract class ProfileRemoteDataSourceContract {
  Future<BaseResponse<UserModel>> getProfileData({String? token});
}
