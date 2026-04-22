part of 'auth_manager_cubit.dart';

class AuthManagerState extends Equatable {
  final BaseState<UserEntity> authState;

  const AuthManagerState({
    this.authState = const BaseState<UserEntity>(
      isLoading: false,
    ),
  });

  AuthManagerState copyWith({BaseState<UserEntity>? authState}) {
    return AuthManagerState(
      authState: authState ?? this.authState,
    );
  }

  @override
  List<Object?> get props => [authState];
}
