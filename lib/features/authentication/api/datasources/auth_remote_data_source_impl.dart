import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/config/error_handler/error_handler.dart';
import 'package:exams_app/features/authentication/api/api_client/auth_api_client.dart';
import 'package:exams_app/features/authentication/data/datasources/auth_local_data_source_contract.dart';
import 'package:exams_app/features/authentication/data/datasources/auth_remote_data_source_contract.dart';
import 'package:exams_app/features/authentication/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSourceContract {
  final AuthApiClient authApiClient;
  final AuthLocalDataSourceContract localDataSource;

  AuthRemoteDataSourceImpl({
    required this.authApiClient,
    required this.localDataSource,
  });

  @override
  Future<BaseResponse<UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authApiClient.login({
        'email': email,
        'password': password,
      });

      await localDataSource.saveToken(response.token);

      return SuccessBaseResponse<UserModel>(response.user);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<UserModel>> register({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    try {
      final response = await authApiClient.register({
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'rePassword': rePassword,
        'phone': phone,
      });

      await localDataSource.saveToken(response.token);

      return SuccessBaseResponse<UserModel>(response.user);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }

  @override
  Future<void> logout() async {
    try {
      final token = await localDataSource.getToken();
      await authApiClient.logout(token ?? '');
      await localDataSource.deleteToken();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<UserModel>> getUserData() async {
    try {
      final token = await localDataSource.getToken();
      if (token == null) {
        return ErrorBaseResponse('No token found');
      }

      final response = await authApiClient.getUserData(token);

      return SuccessBaseResponse<UserModel>(response.user);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }
}
