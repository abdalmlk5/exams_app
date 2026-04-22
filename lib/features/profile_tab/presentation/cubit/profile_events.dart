import '../../domain/entities/profile_user_entity.dart';

sealed class ProfileEvents {
  const ProfileEvents();
}

class GetProfileDataEvent extends ProfileEvents {
  final String? token;

  const GetProfileDataEvent({this.token});
}

class ProfileDataChangedEvent extends ProfileEvents {
  final ProfileUserEntity user;

  const ProfileDataChangedEvent(this.user);
}
