import 'package:equatable/equatable.dart';
import 'package:exams_app/config/base_state/base_state.dart';

class ForgetPasswordState extends Equatable {
  final BaseState<String?> forgetPasswordState;

  const ForgetPasswordState({BaseState<String?>? state})
      : forgetPasswordState = state ?? const BaseState<String?>();

  ForgetPasswordState copyWith({BaseState<String?>? stateParam}) {
    return ForgetPasswordState(state: stateParam ?? forgetPasswordState);
  }

  @override
  List<Object?> get props => [forgetPasswordState];
}
