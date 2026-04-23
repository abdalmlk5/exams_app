import 'package:equatable/equatable.dart';
import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/config/base_state/base_state.dart';
import 'package:exams_app/config/error_handler/error_handler.dart';
import 'package:exams_app/features/authentication/domain/entities/auth_user_entity.dart';
import 'package:exams_app/features/authentication/domain/usecases/get_user_data_usecase.dart';
import 'package:exams_app/features/authentication/domain/usecases/is_remembered_usecase.dart';
import 'package:exams_app/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:exams_app/features/authentication/presentation/auth/cubit/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LogoutUsecase _logoutUseCase;
  final GetUserDataUsecase _getUserDataUseCase;
  final IsRememberedUsecase _isRememberedUseCase;

  AuthCubit(
    this._logoutUseCase,
    this._getUserDataUseCase,
    this._isRememberedUseCase,
  ) : super(const AuthState());

  void checkAuth() async {
    final isRemembered = await _isRememberedUseCase.call();
    if (isRemembered) {
      _getUserData();
    } else {
      emit(
        state.copyWith(
          authState: const BaseState<AuthUserEntity>(
            isLoading: false,
            data: null,
          ),
        ),
      );
    }
  }

  void doEvent(AuthEvent event) {
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
      print('AuthCubit: Logout initiated');
      emit(
        state.copyWith(authState: state.authState.copyWith(isLoading: true)),
      );

      final result = await _logoutUseCase.call();
      print('AuthCubit: Logout usecase result: $result');

      switch (result) {
        case SuccessBaseResponse():
          print('AuthCubit: Logout success');
          emit(
            state.copyWith(
              authState: BaseState<AuthUserEntity>(
                isLoading: false,
                data: null,
              ),
            ),
          );
        case ErrorBaseResponse():
          print('AuthCubit: Logout error: ${result.errorMessage}');
          // Force logout locally even on error
          emit(
            state.copyWith(
              authState: BaseState<AuthUserEntity>(
                isLoading: false,
                data: null,
                errorMessage: result.errorMessage,
              ),
            ),
          );
      }
    } catch (e) {
      print('AuthCubit: Logout exception: $e');
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

      final result = await _getUserDataUseCase.call();

      switch (result) {
        case SuccessBaseResponse<AuthUserEntity>():
          emit(
            state.copyWith(
              authState: BaseState(data: result.data, isLoading: false),
            ),
          );
        case ErrorBaseResponse<AuthUserEntity>():
          emit(
            state.copyWith(
              authState: BaseState<AuthUserEntity>(
                isLoading: false,
                data: null,
                errorMessage: result.errorMessage,
              ),
            ),
          );
      }
    } catch (e) {
      // Clear data and show error on exception
      emit(
        state.copyWith(
          authState: BaseState<AuthUserEntity>(
            isLoading: false,
            data: null,
            errorMessage: ErrorHandler.handle(e),
          ),
        ),
      );
    }
  }
}
