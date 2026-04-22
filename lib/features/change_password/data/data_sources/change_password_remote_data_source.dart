import '../../api/models/change_password_request.dart';

abstract class ChangePasswordRemoteDataSource {
  Future<dynamic> changePassword(ChangePasswordRequest request);
}
