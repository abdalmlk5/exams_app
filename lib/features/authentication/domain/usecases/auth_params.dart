class RegisterParams {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String phone;
  final bool rememberMe;

  RegisterParams({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
    this.rememberMe = false,
  });
}

class LoginParams {
  final String email;
  final String password;
  final bool rememberMe;

  LoginParams({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });
}
