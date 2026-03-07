// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/authentication/api/api_client/auth_api_client.dart'
    as _i326;
import '../../features/authentication/api/datasources/auth_remote_data_source_impl.dart'
    as _i356;
import '../../features/authentication/data/datasources/auth_remote_data_source_contract.dart'
    as _i793;
import '../../features/authentication/data/repositories/auth_repo_impl.dart'
    as _i836;
import '../../features/authentication/domain/repositories/auth_repo_contract.dart'
    as _i880;
import '../../features/authentication/domain/usecases/login_usecase.dart'
    as _i995;
import '../../features/authentication/domain/usecases/register_usecase.dart'
    as _i257;
import '../dio/dio_module.dart' as _i977;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.factory<_i326.AuthApiClient>(() => _i326.AuthApiClient(gh<_i361.Dio>()));
    gh.factory<_i793.AuthRemoteDataSourceContract>(
      () => _i356.AuthRemoteDataSourceImpl(
        authApiClient: gh<_i326.AuthApiClient>(),
      ),
    );
    gh.factory<_i880.AuthRepoContract>(
      () => _i836.AuthRepoImpl(
        authRemoteDataSourceContract: gh<_i793.AuthRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i995.LoginUsecase>(
      () => _i995.LoginUsecase(authRepoContract: gh<_i880.AuthRepoContract>()),
    );
    gh.factory<_i257.RegisterUsecase>(
      () =>
          _i257.RegisterUsecase(authRepoContract: gh<_i880.AuthRepoContract>()),
    );
    return this;
  }
}

class _$DioModule extends _i977.DioModule {}
