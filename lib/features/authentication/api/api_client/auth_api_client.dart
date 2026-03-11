import 'package:dio/dio.dart';
import 'package:exams_app/config/api/end_points.dart';
import 'package:exams_app/features/authentication/data/response/auth_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_client.g.dart';

@injectable
@RestApi()
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(EndPoints.signin)
  Future<AuthResponseModel> login(@Body() Map<String, dynamic> body);

  @POST(EndPoints.register)
  Future<AuthResponseModel> register(@Body() Map<String, dynamic> body);

  @POST(EndPoints.logout)
  Future<void> logout();

  @GET(EndPoints.profileData)
  Future<AuthResponseModel> getUserData();
}
