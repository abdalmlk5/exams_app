import 'package:dio/dio.dart';
import 'package:exams_app/config/api/end_points.dart';
import 'package:exams_app/features/change_password/api/models/change_password_request.dart';
import 'package:exams_app/features/change_password/api/models/change_password_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'change_password_api_client.g.dart';

@injectable
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class ChangePasswordApiClient {
  @factoryMethod
  factory ChangePasswordApiClient(Dio dio) = _ChangePasswordApiClient;

  @PATCH(EndPoints.changePassword)
  Future<ChangePasswordResponse> changePassword(
    @Body() ChangePasswordRequest request,
  );
}
