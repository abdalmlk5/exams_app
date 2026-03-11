part of 'login_cubit.dart';

class LoginState extends Equatable {
  final BaseState<UserEntity> loginState;
  final bool isButtonEnabled;

  const LoginState({
    this.loginState = const BaseState(),
    this.isButtonEnabled = false,
  });

  LoginState copyWith({
    BaseState<UserEntity>? loginState,
    bool? isButtonEnabled,
  }) {
    return LoginState(
      loginState: loginState ?? this.loginState,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }

  @override
  List<Object?> get props => [loginState, isButtonEnabled];
}