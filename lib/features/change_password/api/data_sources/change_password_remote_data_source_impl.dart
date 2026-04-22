import 'package:exams_app/features/change_password/api/api_client/change_password_api_client.dart';
import 'package:exams_app/features/change_password/api/models/change_password_request.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_sources/change_password_remote_data_source.dart';

@Injectable(as: ChangePasswordRemoteDataSource)
class ChangePasswordRemoteDataSourceImpl
    implements ChangePasswordRemoteDataSource {
  final ChangePasswordApiClient _apiClient;

  ChangePasswordRemoteDataSourceImpl(this._apiClient);

  @override
  Future<dynamic> changePassword(ChangePasswordRequest request) {
    return _apiClient.changePassword(request);
  }
}
