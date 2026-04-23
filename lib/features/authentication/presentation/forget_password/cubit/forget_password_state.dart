import '../../../../../config/base_state/base_state.dart';

class ForgetPasswordState {
  final BaseState<String?> forgetPasswordState;

  const ForgetPasswordState({
    this.forgetPasswordState = const BaseState<String?>(isLoading: false),
  });

  ForgetPasswordState copyWith({BaseState<String?>? stateParam}) {
    return ForgetPasswordState(
      forgetPasswordState: stateParam ?? forgetPasswordState,
    );
  }
}
