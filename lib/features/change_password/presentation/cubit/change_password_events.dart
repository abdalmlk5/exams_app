sealed class ChangePasswordEvents {
  const ChangePasswordEvents();
}

class ChangePasswordSubmittedEvent extends ChangePasswordEvents {
  final String oldPassword;
  final String password;
  final String rePassword;

  const ChangePasswordSubmittedEvent({
    required this.oldPassword,
    required this.password,
    required this.rePassword,
  });
}
