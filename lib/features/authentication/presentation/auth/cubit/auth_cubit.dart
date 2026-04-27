import 'package:equatable/equatable.dart';
import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/config/base_state/base_state.dart';
import 'package:exams_app/config/error_handler/error_handler.dart';
import 'package:exams_app/features/authentication/domain/entities/user_entity.dart';
import 'package:exams_app/features/authentication/domain/usecases/get_user_data_usecase.dart';
import 'package:exams_app/features/authentication/domain/usecases/is_remembered_usecase.dart';
import 'package:exams_app/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:exams_app/features/authentication/presentation/auth/cubit/auth_even.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LogoutUsecase _logoutUsecase;
  final GetUserDataUsecase _getUserDataUsecase;
  final IsRememberedUsecase _isRememberedUsecase;

  AuthCubit(
    this._logoutUsecase,
    this._getUserDataUsecase,
    this._isRememberedUsecase,
  ) : super(const AuthState(authState: BaseState(isLoading: true)));

  void checkAuth() async {
    emit(state.copyWith(authState: const BaseState(isLoading: true)));
    final isRemembered = await _isRememberedUsecase.call();
    if (isRemembered) {
      await _getUserData();
    } else {
      emit(
        state.copyWith(
          authState: const BaseState<UserEntity>(isLoading: false, data: null),
        ),
      );
    }
  }

  void doEvent(AuthEven event) {
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
        case SuccessBaseResponse<void>():
          emit(
            state.copyWith(
              authState: const BaseState<UserEntity>(
                isLoading: false,
                data: null,
              ),
            ),
          );
        case ErrorBaseResponse<void>():
          emit(
            state.copyWith(
              authState: state.authState.copyWith(
                errorMessage: result.errorMessage,
                isLoading: false,
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
