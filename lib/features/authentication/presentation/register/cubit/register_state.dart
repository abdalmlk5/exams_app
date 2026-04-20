part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final BaseState<AuthUserEntity> registerState;
  final bool isButtonEnabled;

  const RegisterState({
    this.registerState = const BaseState(),
    this.isButtonEnabled = true,
  });

  RegisterState copyWith({
    BaseState<AuthUserEntity>? registerState,
    bool? isButtonEnabled,
  }) {
    return RegisterState(
      registerState: registerState ?? this.registerState,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }

  @override
  List<Object?> get props => [registerState, isButtonEnabled];
}
