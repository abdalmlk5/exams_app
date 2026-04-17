import 'package:dio/dio.dart';
import 'package:exams_app/config/api/end_points.dart';
import 'package:exams_app/features/authentication/api/models/login_request_body.dart';
import 'package:exams_app/features/authentication/api/models/register_request_body.dart';
import 'package:exams_app/features/authentication/data/response/login_register_responses/auth_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_client.g.dart';

@injectable
@RestApi()
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(EndPoints.signin)
  Future<AuthResponseModel> login(@Body() LoginRequestBody body);

  @POST(EndPoints.register)
  Future<AuthResponseModel> register(@Body() RegisterRequestBody body);

  @POST(EndPoints.logout)
  Future<void> logout();

  @GET(EndPoints.profileData)
  Future<AuthResponseModel> getUserData();
}
