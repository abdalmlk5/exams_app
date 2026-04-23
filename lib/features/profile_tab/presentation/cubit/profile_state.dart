import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/profile_user_entity.dart';

class ProfileState {
  final BaseState<ProfileUserEntity> profileState;
  final bool isDataChanged;

  const ProfileState({
    this.profileState = const BaseState<ProfileUserEntity>(isLoading: true),
    this.isDataChanged = false,
  });

  ProfileState copyWith({
    BaseState<ProfileUserEntity>? stateParam,
    bool? isDataChanged,
  }) {
    return ProfileState(
      profileState: stateParam ?? profileState,
      isDataChanged: isDataChanged ?? this.isDataChanged,
    );
  }
}
