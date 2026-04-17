import 'package:equatable/equatable.dart';
import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/config/base_state/base_state.dart';
import 'package:exams_app/config/error_handler/error_handler.dart';
import 'package:exams_app/features/authentication/domain/entities/user_entity.dart';
import 'package:exams_app/features/authentication/domain/usecases/get_user_data_usecase.dart';
import 'package:exams_app/features/authentication/domain/usecases/is_remembered_usecase.dart';
import 'package:exams_app/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:exams_app/features/authentication/presentation/auth_manager/cubit/auth_manager_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_manager_state.dart';

@injectable
class AuthManagerCubit extends Cubit<AuthManagerState> {
  final LogoutUsecase _logoutUsecase;
  final GetUserDataUsecase _getUserDataUsecase;
  final IsRememberedUsecase _isRememberedUsecase;

  AuthManagerCubit(
    this._logoutUsecase,
    this._getUserDataUsecase,
    this._isRememberedUsecase,
  ) : super(const AuthManagerState());

  void checkAuth() async {
    final isRemembered = await _isRememberedUsecase.call();
    if (isRemembered) {
      _getUserData();
    } else {
      emit(
        state.copyWith(
          authState: const BaseState<UserEntity>(isLoading: false, data: null),
        ),
      );
    }
  }

  void doEvent(AuthManagerEvent event) {
    switch (event) {
      case Logout():
        _logout();
        break;
      case GetUserData():
        _getUserData();
        break;
    }
  }

  Future<void> _logout() async {
    try {
      emit(
        state.copyWith(authState: state.authState.copyWith(isLoading: true)),
      );

      final result = await _logoutUsecase.call();

      switch (result) {
        case SuccessBaseResponse():
          emit(
            state.copyWith(
              authState: BaseState<UserEntity>(
                isLoading: false,
                data: null,
              ),
            ),
          );
        case ErrorBaseResponse():
          // Force logout locally even on error
          emit(
            state.copyWith(
              authState: BaseState<UserEntity>(
                isLoading: false,
                data: null,
                errorMessage: result.error,
              ),
            ),
          );
      }
    } catch (e) {
      emit(
        state.copyWith(
          authState: BaseState(
            errorMessage: ErrorHandler.handle(e),
            isLoading: false,
          ),
        ),
      );
    }
  }

  Future<void> _getUserData() async {
    try {
      emit(
        state.copyWith(authState: state.authState.copyWith(isLoading: true)),
      );

      final result = await _getUserDataUsecase.call();

      switch (result) {
        case SuccessBaseResponse<UserEntity>():
          emit(
            state.copyWith(
              authState: BaseState(data: result.data, isLoading: false),
            ),
          );
        case ErrorBaseResponse<UserEntity>():
          emit(
            state.copyWith(
              authState: const BaseState<UserEntity>(
                isLoading: false,
                data: null,
              ),
            ),
          );
      }
    } catch (e) {
      // Clear data on exception
      emit(
        state.copyWith(
          authState: const BaseState<UserEntity>(isLoading: false, data: null),
        ),
      );
    }
  }
}

