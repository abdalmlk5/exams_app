import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/change_password/api/models/change_password_request.dart';

abstract class ChangePasswordRepo {
  Future<BaseResponse<String>> changePassword(ChangePasswordRequest request);
}
