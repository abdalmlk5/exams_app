import 'package:exams_app/config/base_state/base_state.dart';

class ForgetPasswordState {
  BaseState<String?> forgetPasswordState = BaseState<String?>(
    isLoading: true,
    data: null,
  );
  bool isButtonEnabled;

  ForgetPasswordState({BaseState<String?>? state, this.isButtonEnabled = true}) {
    forgetPasswordState =
        state ?? BaseState<String?>(isLoading: false, data: null);
  }

  ForgetPasswordState copyWith({BaseState<String?>? stateParam, bool? isButtonEnabled}) {
    return ForgetPasswordState(
      state: stateParam ?? forgetPasswordState,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }
}
