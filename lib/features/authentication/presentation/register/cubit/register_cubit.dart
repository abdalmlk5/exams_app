import 'package:equatable/equatable.dart';
import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/config/base_state/base_state.dart';
import 'package:exams_app/config/error_handler/error_handler.dart';
import 'package:exams_app/config/validations/app_validations.dart';
import 'package:exams_app/features/authentication/domain/entities/auth_user_entity.dart';
import 'package:exams_app/features/authentication/domain/usecases/register_usecase.dart';
import 'package:exams_app/features/authentication/presentation/register/cubit/register_even.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUsecase _registerUsecase;

  RegisterCubit(this._registerUsecase) : super(const RegisterState());

  void doEvent(RegisterEven event) {
    switch (event) {
      case Register():
        _register(event);
        break;
    }
  }

  void validateForm({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) {
    final isValid =
        AppValidations.validateUserName(username) == null &&
        AppValidations.validateFirstName(firstName) == null &&
        AppValidations.validateLastName(lastName) == null &&
        AppValidations.validateEmail(email) == null &&
        AppValidations.validatePassword(password) == null &&
        AppValidations.validateConfirmPassword(rePassword, password) == null &&
        AppValidations.validatePhoneNumber(phone) == null;

    emit(state.copyWith(isButtonEnabled: isValid));
  }

  Future<void> _register(Register event) async {
    try {
      emit(state.copyWith(registerState: const BaseState(isLoading: true)));

      final result = await _registerUsecase.call(
        username: event.username,
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        password: event.password,
        rePassword: event.rePassword,
        phone: event.phone,
      );

      switch (result) {
        case SuccessBaseResponse<AuthUserEntity>():
          emit(
            state.copyWith(
              registerState: BaseState(data: result.data, isLoading: false),
            ),
          );
        case ErrorBaseResponse<AuthUserEntity>():
          emit(
            state.copyWith(
              registerState: BaseState(
                isLoading: false,
                errorMessage: result.errorMessage,
              ),
            ),
          );
      }
    } catch (e) {
      emit(
        state.copyWith(
          registerState: BaseState(
            isLoading: false,
            errorMessage: ErrorHandler.handle(e),
          ),
        ),
      );
    }
  }
}
