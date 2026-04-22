import 'package:dio/dio.dart';
import 'package:exams_app/config/api/end_points.dart';
import 'package:exams_app/features/profile_tab/data/models/profile_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api_client.g.dart';

@injectable
@RestApi()
abstract class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio) = _ProfileApiClient;

  @GET(EndPoints.profileData)
  Future<ProfileResponse> getProfileData(
    @Queries() Map<String, dynamic> queries,
  );
}
