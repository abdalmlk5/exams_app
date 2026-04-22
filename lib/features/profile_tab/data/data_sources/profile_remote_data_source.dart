import 'package:exams_app/features/profile_tab/data/models/profile_response.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileResponse> getProfileData();
  Future<ProfileResponse> updateProfile(Map<String, dynamic> body);
}
