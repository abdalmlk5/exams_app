import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/core/models/user_model.dart';
import 'package:exams_app/features/profile_tab/api/api_client/profile_api_client.dart';
import 'package:exams_app/features/profile_tab/data/models/profile_response.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handler/error_handler.dart';
import '../../data/data_sources/profile_remote_data_source.dart';

@Injectable(as: ProfileRemoteDataSourceContract)
class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSourceContract {
  final ProfileApiClient apiClient;

  ProfileRemoteDataSourceImpl(this.apiClient);

  @override
  Future<BaseResponse<UserModel>> getProfileData({String? token}) async {
    try {
      final ProfileResponse response = await apiClient.getProfileData({
        "token": token,
      });
      return SuccessBaseResponse<UserModel>(response.user ?? UserModel());
    } catch (e) {
      return ErrorBaseResponse<UserModel>(ErrorHandler.handle(e));
    }
  }
}
