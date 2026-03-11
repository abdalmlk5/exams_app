import 'package:exams_app/config/base_state/base_state.dart';
import 'package:exams_app/config/validations/app_validations.dart';
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
        _login(email: event.email, password: event.password);
        break;
    }
  }

  void validateForm(String email, String password) {
    final emailError = AppValidations.validateEmail(email);
    final passwordError = AppValidations.validatePassword(password);

    final isValid = emailError == null &&
        passwordError == null &&
        email.trim().isNotEmpty &&
        password.trim().isNotEmpty;

    emit(state.copyWith(isButtonEnabled: isValid));
  }

  Future<void> _login({
    required String email,
    required final String password,
  }) async {
    try {
      emit(
        state.copyWith(loginState: state.loginState.copyWith(isLoading: true)),
      );

      final result = await _loginUsecase.call(email: email, password: password);

      switch (result) {
        case SuccessBaseResponse<UserEntity>():
          emit(
            state.copyWith(
              loginState: state.loginState.copyWith(
                isLoading: false,
                data: result.data,
              ),
            ),
          );
        case ErrorBaseResponse<UserEntity>():
          emit(
            state.copyWith(
              loginState: state.loginState.copyWith(
                isLoading: false,
                errorMessage: result.error,
              ),
            ),
          );
      }
    } catch (e) {
      emit(
        state.copyWith(
          loginState: state.loginState.copyWith(
            isLoading: false,
            errorMessage: ErrorHandler.handle(e),
          ),
        ),
      );
    }
  }
}
