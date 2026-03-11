import 'package:dio/dio.dart';
import 'package:exams_app/config/api/end_points.dart';
import 'package:exams_app/features/forget_password/data/models/forget_password_response.dart';
import 'package:exams_app/features/forget_password/data/models/reset_password_response.dart';
import 'package:exams_app/features/forget_password/data/models/verify_code_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_client.g.dart';

@injectable
@RestApi()
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(EndPoints.forgetPassword)
  @FormUrlEncoded()
  Future<ForgetPasswordResponse> forgetPassword(@Field("email") String email);

  @POST(EndPoints.verifyResetCode)
  @FormUrlEncoded()
  Future<VerifyCodeResponse> verifyResetCode(
    @Field("resetCode") String resetCode,
  );

  @PUT(EndPoints.resetPassword)
  @FormUrlEncoded()
  Future<ResetPasswordResponse> resetPassword(
    @Field("email") String email,
    @Field("newPassword") String newPassword,
  );
}
