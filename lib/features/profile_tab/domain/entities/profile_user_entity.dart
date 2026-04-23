import 'package:equatable/equatable.dart';

class ProfileUserEntity extends Equatable {
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;

  const ProfileUserEntity({
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [
    username,
    firstName,
    lastName,
    email,
    phoneNumber,
  ];
}
