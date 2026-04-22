// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/authentication/api/api_client/auth_api_client.dart'
    as _i326;
import '../../features/authentication/api/datasources/auth_local_data_source_impl.dart'
    as _i798;
import '../../features/authentication/api/datasources/auth_remote_data_source_impl.dart'
    as _i356;
import '../../features/authentication/data/datasources/auth_local_data_source_contract.dart'
    as _i741;
import '../../features/authentication/data/datasources/auth_remote_data_source_contract.dart'
    as _i793;
import '../../features/authentication/data/repositories/auth_repo_impl.dart'
    as _i836;
import '../../features/authentication/domain/repositories/auth_repo.dart'
    as _i802;
<<<<<<< Updated upstream
=======
import '../../features/authentication/domain/usecases/forget_password_use_case.dart'
    as _i601;
>>>>>>> Stashed changes
import '../../features/authentication/domain/usecases/get_user_data_usecase.dart'
    as _i932;
import '../../features/authentication/domain/usecases/is_remembered_usecase.dart'
    as _i330;
import '../../features/authentication/domain/usecases/login_usecase.dart'
    as _i995;
import '../../features/authentication/domain/usecases/logout_usecase.dart'
    as _i1067;
import '../../features/authentication/domain/usecases/register_usecase.dart'
    as _i257;
import '../../features/authentication/presentation/auth_manager/cubit/auth_manager_cubit.dart'
    as _i272;
import '../../features/authentication/presentation/login/cubit/login_cubit.dart'
    as _i339;
import '../../features/authentication/presentation/register/cubit/register_cubit.dart'
    as _i633;
<<<<<<< Updated upstream
import '../dio/auth_interceptor.dart' as _i839;
=======
import '../../features/exam_results/data/datasources/exam_results_local_datasource_contract.dart'
    as _i608;
import '../../features/exam_results/data/datasources/exam_results_local_datasource_impl.dart'
    as _i275;
import '../../features/exam_results/data/repositories/exam_results_repo_impl.dart'
    as _i924;
import '../../features/exam_results/domain/repositories/exam_results_repo.dart'
    as _i428;
import '../../features/exam_results/domain/usecases/get_exam_results_usecase.dart'
    as _i192;
import '../../features/exam_results/domain/usecases/save_exam_result_usecase.dart'
    as _i580;
import '../../features/exam_results/presentation/cubit/exam_results_cubit.dart'
    as _i579;
import '../../features/exams/api/api_client/exams_api_client.dart' as _i188;
import '../../features/exams/api/datasources/exams_data_source_impl.dart'
    as _i863;
import '../../features/exams/data/datasources/exams_data_source_contract.dart'
    as _i797;
import '../../features/exams/data/repositories/exams_repo_impl.dart' as _i407;
import '../../features/exams/domain/repository/exams_repo.dart' as _i497;
import '../../features/exams/domain/use_cases/get_exams_use_case.dart' as _i854;
import '../../features/exams/presentation/cubit/exams_cubit.dart' as _i833;
import '../../features/explore/api/api_client/explore_api_client.dart'
    as _i1020;
import '../../features/explore/api/datasources/explore_data_source_impl.dart'
    as _i118;
import '../../features/explore/data/datasources/explore_data_source_contract.dart'
    as _i678;
import '../../features/explore/data/repositories/explore_repo_impl.dart'
    as _i835;
import '../../features/explore/domain/repository/explore_repo.dart' as _i1046;
import '../../features/explore/domain/use_cases/get_subjects_use_case.dart'
    as _i593;
import '../../features/explore/presentation/cubit/explore_cubit.dart' as _i742;
import '../../features/home_screen/presentation/cubit/home_cubit.dart' as _i881;
import '../../features/questions/api/api_client/question_api_client.dart'
    as _i266;
import '../../features/questions/api/datasources/question_remote_data_source_impl.dart'
    as _i258;
import '../../features/questions/data/datasources/question_remote_data_source_contract.dart'
    as _i470;
import '../../features/questions/data/repositories/question_repo_impl.dart'
    as _i804;
import '../../features/questions/domain/repositories/question_repo.dart'
    as _i342;
import '../../features/questions/domain/usecases/get_questions_usecase.dart'
    as _i309;
import '../../features/questions/domain/usecases/submit_answers_usecase.dart'
    as _i912;
import '../../features/questions/presentation/cubit/questions_cubit.dart'
    as _i19;
>>>>>>> Stashed changes
import '../dio/dio_module.dart' as _i977;
import '../local/local_module.dart' as _i722;
import '../usecases/get_user_data_usecase.dart' as _i352;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final localModule = _$LocalModule();
    final dioModule = _$DioModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => localModule.secureStorage,
    );
    gh.factory<_i608.ExamResultsLocalDataSourceContract>(
      () => _i275.ExamResultsLocalDataSourceImpl(),
    );
    gh.factory<_i741.AuthLocalDataSourceContract>(
      () => _i798.AuthLocalDataSourceImpl(gh<_i558.FlutterSecureStorage>()),
    );
<<<<<<< Updated upstream
    gh.factory<_i839.AuthInterceptor>(
      () => _i839.AuthInterceptor(gh<_i741.AuthLocalDataSourceContract>()),
=======
    gh.factory<_i428.ExamResultsRepo>(
      () => _i924.ExamResultsRepoImpl(
        gh<_i608.ExamResultsLocalDataSourceContract>(),
      ),
>>>>>>> Stashed changes
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.dio(gh<_i839.AuthInterceptor>()),
    );
    gh.factory<_i192.GetExamResultsUseCase>(
      () => _i192.GetExamResultsUseCase(gh<_i428.ExamResultsRepo>()),
    );
    gh.factory<_i580.SaveExamResultUseCase>(
      () => _i580.SaveExamResultUseCase(gh<_i428.ExamResultsRepo>()),
    );
    gh.factory<_i326.AuthApiClient>(() => _i326.AuthApiClient(gh<_i361.Dio>()));
    gh.factory<_i793.AuthRemoteDataSourceContract>(
      () => _i356.AuthRemoteDataSourceImpl(
        authApiClient: gh<_i326.AuthApiClient>(),
        localDataSource: gh<_i741.AuthLocalDataSourceContract>(),
      ),
    );
<<<<<<< Updated upstream
=======
    gh.factory<_i797.ExamsDataSourceContract>(
      () => _i863.ExamsDataSourceImpl(gh<_i188.ExamsApiClient>()),
    );
    gh.factory<_i497.ExamsRepo>(
      () => _i407.ExamsRepoImpl(gh<_i797.ExamsDataSourceContract>()),
    );
    gh.factory<_i579.ExamResultsCubit>(
      () => _i579.ExamResultsCubit(
        gh<_i192.GetExamResultsUseCase>(),
        gh<_i580.SaveExamResultUseCase>(),
      ),
    );
    gh.factory<_i678.ExploreDataSourceContract>(
      () => _i118.ExploreDataSourceImpl(gh<_i1020.ExploreApiClient>()),
    );
>>>>>>> Stashed changes
    gh.factory<_i802.AuthRepo>(
      () => _i836.AuthRepoImpl(
        authRemoteDataSourceContract: gh<_i793.AuthRemoteDataSourceContract>(),
        authLocalDataSourceContract: gh<_i741.AuthLocalDataSourceContract>(),
      ),
    );
<<<<<<< Updated upstream
=======
    gh.factory<_i309.GetQuestionsUsecase>(
      () => _i309.GetQuestionsUsecase(
        questionRepoContract: gh<_i342.QuestionRepoContract>(),
      ),
    );
    gh.factory<_i912.SubmitAnswersUsecase>(
      () => _i912.SubmitAnswersUsecase(
        questionRepoContract: gh<_i342.QuestionRepoContract>(),
      ),
    );
    gh.factory<_i19.QuestionsCubit>(
      () => _i19.QuestionsCubit(
        gh<_i309.GetQuestionsUsecase>(),
        gh<_i912.SubmitAnswersUsecase>(),
        gh<_i580.SaveExamResultUseCase>(),
      ),
    );
    gh.factory<_i854.GetExamsUseCase>(
      () => _i854.GetExamsUseCase(gh<_i497.ExamsRepo>()),
    );
    gh.factory<_i352.GetUserDataUsecase>(
      () => _i352.GetUserDataUsecase(authRepoContract: gh<_i802.AuthRepo>()),
    );
>>>>>>> Stashed changes
    gh.factory<_i932.GetUserDataUsecase>(
      () => _i932.GetUserDataUsecase(authRepoContract: gh<_i802.AuthRepo>()),
    );
    gh.factory<_i330.IsRememberedUsecase>(
      () => _i330.IsRememberedUsecase(authRepoContract: gh<_i802.AuthRepo>()),
    );
    gh.factory<_i995.LoginUsecase>(
      () => _i995.LoginUsecase(authRepoContract: gh<_i802.AuthRepo>()),
    );
    gh.factory<_i1067.LogoutUsecase>(
      () => _i1067.LogoutUsecase(authRepoContract: gh<_i802.AuthRepo>()),
    );
    gh.factory<_i257.RegisterUsecase>(
      () => _i257.RegisterUsecase(authRepoContract: gh<_i802.AuthRepo>()),
    );
    gh.factory<_i633.RegisterCubit>(
      () => _i633.RegisterCubit(gh<_i257.RegisterUsecase>()),
    );
<<<<<<< Updated upstream
    gh.factory<_i272.AuthManagerCubit>(
      () => _i272.AuthManagerCubit(
=======
    gh.factory<_i1046.ExploreRepo>(
      () => _i835.ExploreRepoImpl(gh<_i678.ExploreDataSourceContract>()),
    );
    gh.factory<_i593.GetSubjectsUseCase>(
      () => _i593.GetSubjectsUseCase(gh<_i1046.ExploreRepo>()),
    );
    gh.factory<_i788.AuthCubit>(
      () => _i788.AuthCubit(
>>>>>>> Stashed changes
        gh<_i1067.LogoutUsecase>(),
        gh<_i932.GetUserDataUsecase>(),
        gh<_i330.IsRememberedUsecase>(),
      ),
    );
    gh.factory<_i339.LoginCubit>(
      () => _i339.LoginCubit(gh<_i995.LoginUsecase>()),
    );
    return this;
  }
}

class _$LocalModule extends _i722.LocalModule {}

class _$DioModule extends _i977.DioModule {}
