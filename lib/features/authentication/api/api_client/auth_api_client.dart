import 'package:dio/dio.dart';
import 'package:exams_app/features/authentication/data/response/auth_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_client.g.dart';

@injectable
@RestApi()
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST("/auth/signin")
  Future<AuthResponseModel> login(@Body() Map<String, dynamic> body);

  @POST("/auth/signup")
  Future<AuthResponseModel> register(@Body() Map<String, dynamic> body);

  @POST("/auth/logout")
  Future<void> logout(@Header("token") String token);

  @GET("/auth/profileData")
  Future<AuthResponseModel> getUserData(@Header("token") String token);
}
