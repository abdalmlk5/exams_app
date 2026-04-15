import 'package:exams_app/config/base_state/base_state.dart';
import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/config/error_handler/error_handler.dart';
import 'package:exams_app/features/authentication/domain/entities/user_entity.dart';
import 'package:exams_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:exams_app/features/authentication/presentation/login/cubit/login_even.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase _loginUsecase;
  LoginCubit(this._loginUsecase) : super(const LoginState());

  void doEvent(LoginEven event) {
    switch (event) {
      case Login():
        _login(
          email: event.email,
          password: event.password,
          rememberMe: event.rememberMe,
        );
        break;
    }
  }


  void toggleRememberMe(bool value) {
    emit(state.copyWith(rememberMe: value));
  }

  Future<void> _login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      // Fresh BaseState clears any previous error/data automatically
      emit(state.copyWith(loginState: const BaseState(isLoading: true)));

      final result = await _loginUsecase.call(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );

      switch (result) {
        case SuccessBaseResponse<UserEntity>():
          emit(state.copyWith(
            loginState: BaseState(data: result.data, isLoading: false),
          ));
        case ErrorBaseResponse<UserEntity>():
          emit(state.copyWith(
            loginState: BaseState(
              isLoading: false,
              errorMessage: result.error,
            ),
          ));
      }
    } catch (e) {
      emit(state.copyWith(
        loginState: BaseState(
          isLoading: false,
          errorMessage: ErrorHandler.handle(e),
        ),
      ));
    }
  }
}
