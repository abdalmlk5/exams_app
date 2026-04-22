sealed class AuthManagerEvent {}

class Logout extends AuthManagerEvent {}

class GetUserData extends AuthManagerEvent {}

class CheckAuth extends AuthManagerEvent {}
