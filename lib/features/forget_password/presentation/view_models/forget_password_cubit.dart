import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/config/base_state/base_state.dart';
import 'package:exams_app/features/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:exams_app/features/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:exams_app/features/forget_password/domain/use_cases/verify_code_use_case.dart';
import 'package:exams_app/features/forget_password/presentation/view_models/forget_password_intent.dart';
import 'package:exams_app/core/utils/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordCubit extends Cubit<BaseState<String?>> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final VerifyCodeUseCase _verifyCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  String? _userEmail;

  ForgetPasswordCubit(
    this._forgetPasswordUseCase,
    this._verifyCodeUseCase,
    this._resetPasswordUseCase,
  ) : super(const BaseState(isLoading: false, data: null));

  void handleIntent(ForgetPasswordIntent intent) {
    if (intent is ForgetPasswordSendEmailIntent) {
      _userEmail = intent.email;
      _forgetPassword(intent.email);
    } else if (intent is ForgetPasswordVerifyCodeIntent) {
      _verifyCode(intent.code);
    } else if (intent is ForgetPasswordResetPasswordIntent) {
      _resetPassword(intent.password);
    }
  }

  void _forgetPassword(String email) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearData: true));
    final result = await _forgetPasswordUseCase.call(email);
    switch (result) {
      case SuccessBaseResponse():
        emit(state.copyWith(isLoading: false, data: AppStrings.otpSent));
      case ErrorBaseResponse():
        emit(state.copyWith(isLoading: false, errorMessage: result.error));
    }
  }

  void _verifyCode(String code) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await _verifyCodeUseCase.call(code);
    switch (result) {
      case SuccessBaseResponse():
        emit(state.copyWith(isLoading: false, data: AppStrings.codeVerified));
      case ErrorBaseResponse():
        emit(state.copyWith(isLoading: false, errorMessage: result.error));
    }
  }

  void _resetPassword(String password) async {
    if (_userEmail == null) {
      emit(state.copyWith(errorMessage: AppStrings.emailMissing));
      return;
    }
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await _resetPasswordUseCase.call(_userEmail!, password);
    switch (result) {
      case SuccessBaseResponse():
        emit(state.copyWith(isLoading: false, data: AppStrings.passwordReset));
      case ErrorBaseResponse():
        emit(state.copyWith(isLoading: false, errorMessage: result.error));
    }
  }
}
