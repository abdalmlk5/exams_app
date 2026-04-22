import 'package:exams_app/features/profile_tab/api/api_client/profile_api_client.dart';
import 'package:exams_app/features/profile_tab/data/models/profile_response.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_sources/profile_remote_data_source.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiClient apiClient;

  ProfileRemoteDataSourceImpl(this.apiClient);

  @override
  Future<ProfileResponse> getProfileData() async {
    return await apiClient.getProfileData();
  }

  @override
  Future<ProfileResponse> updateProfile(Map<String, dynamic> body) async {
    return await apiClient.updateProfile(body);
  }
}
