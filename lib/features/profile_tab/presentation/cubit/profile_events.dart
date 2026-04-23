import '../../domain/entities/profile_user_entity.dart';

sealed class ProfileEvents {
  const ProfileEvents();
}

class GetProfileDataEvent extends ProfileEvents {
  const GetProfileDataEvent();
}

class ProfileDataChangedEvent extends ProfileEvents {
  final ProfileUserEntity user;

  const ProfileDataChangedEvent(this.user);
}

class UpdateProfileEvent extends ProfileEvents {
  const UpdateProfileEvent();
}
