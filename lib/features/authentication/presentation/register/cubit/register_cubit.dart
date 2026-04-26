import 'package:equatable/equatable.dart';
import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/config/base_state/base_state.dart';
import 'package:exams_app/features/authentication/domain/entities/user_entity.dart';
import 'package:exams_app/features/authentication/domain/usecases/register_usecase.dart';
import 'package:exams_app/features/authentication/presentation/register/cubit/register_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUsecase _registerUsecase;

  RegisterCubit(this._registerUsecase) : super(const RegisterState());

  void doEvent(RegisterEvent event) {
    switch (event) {
      case Register():
        _register(event);
        break;
      case ChangeButtonStatus():
        emit(state.copyWith(isButtonEnabled: event.isEnabled));
        break;
    }
  }

  Future<void> _register(Register event) async {
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
      case SuccessBaseResponse<UserEntity>():
        emit(
          state.copyWith(
            registerState: BaseState(data: result.data, isLoading: false),
          ),
        );
      case ErrorBaseResponse<UserEntity>():
        emit(
          state.copyWith(
            registerState: BaseState(
              isLoading: false,
              errorMessage: result.errorMessage,
            ),
          ),
        );
    }
  }
}
