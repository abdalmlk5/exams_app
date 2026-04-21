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

import '../../features/forget_password/api/api_client/auth_api_client.dart'
    as _i940;
import '../../features/forget_password/api/data_sources/auth_remote_data_source_impl.dart'
    as _i847;
import '../../features/forget_password/data/data_sources/auth_remote_data_source.dart'
    as _i984;
import '../../features/forget_password/data/repo/forget_password_repo_impl.dart'
    as _i576;
import '../../features/forget_password/domain/repo/forget_password_repo.dart'
    as _i699;
import '../../features/forget_password/domain/use_cases/forget_password_use_case.dart'
    as _i437;
import '../../features/forget_password/domain/use_cases/reset_password_use_case.dart'
    as _i56;
import '../../features/forget_password/domain/use_cases/verify_code_use_case.dart'
    as _i925;
import '../../features/forget_password/presentation/view_models/forget_password_cubit.dart'
    as _i559;
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
    gh.factory<_i940.AuthApiClient>(() => _i940.AuthApiClient(gh<_i361.Dio>()));
    gh.factory<_i984.AuthRemoteDataSource>(
      () => _i847.AuthRemoteDataSourceImpl(gh<_i940.AuthApiClient>()),
    );
    gh.factory<_i699.ForgetPasswordRepo>(
      () => _i576.ForgetPasswordRepoImpl(gh<_i984.AuthRemoteDataSource>()),
    );
    gh.factory<_i437.ForgetPasswordUseCase>(
      () => _i437.ForgetPasswordUseCase(gh<_i699.ForgetPasswordRepo>()),
    );
    gh.factory<_i56.ResetPasswordUseCase>(
      () => _i56.ResetPasswordUseCase(gh<_i699.ForgetPasswordRepo>()),
    );
    gh.factory<_i925.VerifyCodeUseCase>(
      () => _i925.VerifyCodeUseCase(gh<_i699.ForgetPasswordRepo>()),
    );
    gh.factory<_i559.ForgetPasswordCubit>(
      () => _i559.ForgetPasswordCubit(
        gh<_i437.ForgetPasswordUseCase>(),
        gh<_i925.VerifyCodeUseCase>(),
        gh<_i56.ResetPasswordUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i977.DioModule {}
