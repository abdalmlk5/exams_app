import 'package:exams_app/config/base_state/base_state.dart';

class ChangePasswordState {
  final BaseState<String> changePasswordResult;

  const ChangePasswordState({
    this.changePasswordResult = const BaseState<String>(),
  });

  ChangePasswordState copyWith({BaseState<String>? changePasswordResult}) {
    return ChangePasswordState(
      changePasswordResult: changePasswordResult ?? this.changePasswordResult,
    );
  }
}
