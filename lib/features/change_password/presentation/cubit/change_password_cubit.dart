import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/config/base_state/base_state.dart';
import 'package:exams_app/features/change_password/api/models/change_password_request.dart';
import 'package:exams_app/features/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:exams_app/features/change_password/presentation/cubit/change_password_events.dart';
import 'package:exams_app/features/change_password/presentation/cubit/change_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _useCase;

  ChangePasswordCubit(this._useCase) : super(const ChangePasswordState());

  void doEvent(ChangePasswordEvents event) {
    switch (event) {
      case ChangePasswordSubmittedEvent():
        _changePassword(event.oldPassword, event.password, event.rePassword);
        break;
    }
  }

  void _changePassword(
    String oldPassword,
    String password,
    String rePassword,
  ) async {
    emit(
      state.copyWith(changePasswordResult: const BaseState(isLoading: true)),
    );

    final result = await _useCase.call(
      ChangePasswordRequest(
        oldPassword: oldPassword,
        password: password,
        rePassword: rePassword,
      ),
    );

    switch (result) {
      case SuccessBaseResponse():
        emit(
          state.copyWith(
            changePasswordResult: BaseState(
              isLoading: false,
              data: result.data,
            ),
          ),
        );
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            changePasswordResult: BaseState(
              isLoading: false,
              errorMessage: result.errorMessage,
            ),
          ),
        );
    }
  }
}
