part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final BaseState<UserEntity> authState;

  const AuthState({
    this.authState = const BaseState<UserEntity>(
      isLoading: false,
    ),
  });

  AuthState copyWith({BaseState<UserEntity>? authState}) {
    return AuthState(
      authState: authState ?? this.authState,
    );
  }

  @override
  List<Object?> get props => [authState];
}
