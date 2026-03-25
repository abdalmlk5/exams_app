import 'package:exams_app/config/base_state/base_state.dart';

class ForgetPasswordState {
  BaseState<String?> forgetPasswordState = BaseState<String?>(
    isLoading: true,
    data: null,
  );

  ForgetPasswordState({BaseState<String?>? state}) {
    forgetPasswordState =
        state ?? BaseState<String?>(isLoading: false, data: null);
  }

  ForgetPasswordState copyWith({BaseState<String?>? stateParam}) {
    return ForgetPasswordState(state: stateParam ?? forgetPasswordState);
  }
}
