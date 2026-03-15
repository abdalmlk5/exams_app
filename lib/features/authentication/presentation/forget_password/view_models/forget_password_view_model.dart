import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/authentication/domain/usecases/forget_password_use_case.dart';
import 'package:exams_app/features/authentication/domain/usecases/verify_code_use_case.dart';
import 'package:exams_app/features/authentication/presentation/forget_password/view_models/forget_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/reset_password_use_case.dart';
import 'forget_password_event.dart';

@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final VerifyCodeUseCase _verifyCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  String? _userEmail;

  ForgetPasswordViewModel(
    this._forgetPasswordUseCase,
    this._verifyCodeUseCase,
    this._resetPasswordUseCase,
  ) : super(ForgetPasswordState());

  void doEvent(ForgetPasswordEvent event) {
    switch (event) {
      case ForgetPasswordSendEmailEvent():
        _forgetPassword(event.email);
        break;
      case ForgetPasswordVerifyCodeEvent():
        _verifyCode(event.code);
        break;
      case ForgetPasswordResetPasswordEvent():
        _resetPassword(event.password, event.confirmPassword);
        break;
    }
  }

  void _forgetPassword(String email) async {
    _userEmail = email;
    emit(
      state.copyWith(
        stateParam: state.forgetPasswordState.copyWith(
          isLoading: true,
          data: null,
          errorMessage: null,
        ),
      ),
    );

    final result = await _forgetPasswordUseCase.call(email);
    switch (result) {
      case SuccessBaseResponse():
        emit(
          state.copyWith(
            stateParam: state.forgetPasswordState.copyWith(
              isLoading: false,
              data: result.data.info,
            ),
          ),
        );
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            stateParam: state.forgetPasswordState.copyWith(
              isLoading: false,
              errorMessage: result.error,
            ),
          ),
        );
    }
  }

  void _verifyCode(String code) async {
    emit(
      state.copyWith(
        stateParam: state.forgetPasswordState.copyWith(
          isLoading: true,
          data: null,
          errorMessage: null,
        ),
      ),
    );
    final result = await _verifyCodeUseCase.call(code);
    switch (result) {
      case SuccessBaseResponse():
        emit(
          state.copyWith(
            stateParam: state.forgetPasswordState.copyWith(
              isLoading: false,
              data: result.data.status,
            ),
          ),
        );
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            stateParam: state.forgetPasswordState.copyWith(
              isLoading: false,
              errorMessage: result.error,
            ),
          ),
        );
    }
  }

  void _resetPassword(String password, String confirmPassword) async {
    if (_userEmail == null) {
      emit(
        state.copyWith(
          stateParam: state.forgetPasswordState.copyWith(
            isLoading: false,
            errorMessage: "Email is missing, please go back to step 1",
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        stateParam: state.forgetPasswordState.copyWith(
          isLoading: true,
          data: null,
          errorMessage: null,
        ),
      ),
    );

    final result = await _resetPasswordUseCase.call(_userEmail!, password);
    switch (result) {
      case SuccessBaseResponse():
        emit(
          state.copyWith(
            stateParam: state.forgetPasswordState.copyWith(
              isLoading: false,
              data: result.data.message,
            ),
          ),
        );
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            stateParam: state.forgetPasswordState.copyWith(
              isLoading: false,
              errorMessage: result.error,
            ),
          ),
        );
    }
  }
}
