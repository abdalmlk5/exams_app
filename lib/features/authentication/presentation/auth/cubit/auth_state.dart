part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final BaseState<AuthUserEntity> authState;

  const AuthState({
    this.authState = const BaseState<AuthUserEntity>(isLoading: false),
  });

  AuthState copyWith({BaseState<AuthUserEntity>? authState}) {
    return AuthState(authState: authState ?? this.authState);
  }

  @override
  List<Object?> get props => [authState];
}
