import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/config/cache_helper/cache_helper.dart';
import 'package:exams_app/config/error_handler/error_handler.dart';
import 'package:exams_app/features/change_password/api/models/change_password_request.dart';
import 'package:exams_app/features/change_password/data/data_sources/change_password_remote_data_source.dart';
import 'package:exams_app/features/change_password/domain/repositories/change_password_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordRepo)
class ChangePasswordRepoImpl implements ChangePasswordRepo {
  final ChangePasswordRemoteDataSource _remoteDataSource;

  ChangePasswordRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<String>> changePassword(
    ChangePasswordRequest request,
  ) async {
    try {
      final response = await _remoteDataSource.changePassword(request);

      if (response.token != null) {
        await CacheHelper.saveToken(response.token!);
      }

      return SuccessBaseResponse(response.message ?? "Success");
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }
}
