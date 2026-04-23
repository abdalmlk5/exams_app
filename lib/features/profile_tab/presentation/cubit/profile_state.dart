import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/profile_user_entity.dart';

enum ProfileStatus { idle, loading, success, error }

class ProfileState {
  final BaseState<ProfileUserEntity> profileState;
  final bool isDataChanged;
  final ProfileStatus status;

  const ProfileState({
    this.profileState = const BaseState<ProfileUserEntity>(isLoading: true),
    this.isDataChanged = false,
    this.status = ProfileStatus.idle,
  });

  ProfileState copyWith({
    BaseState<ProfileUserEntity>? stateParam,
    bool? isDataChanged,
    ProfileStatus? status,
  }) {
    return ProfileState(
      profileState: stateParam ?? profileState,
      isDataChanged: isDataChanged ?? this.isDataChanged,
      status: status ?? this.status,
    );
  }
}
