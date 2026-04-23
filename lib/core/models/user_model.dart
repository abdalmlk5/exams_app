import 'package:exams_app/features/profile_tab/domain/entities/profile_user_entity.dart';
import 'package:exams_app/features/authentication/domain/entities/auth_user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  @JsonKey(name: 'phone')
  final String? phoneNumber;
  final String? role;
  final bool? isVerified;
  final String? createdAt;

  const UserModel({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.role,
    this.isVerified,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  AuthUserEntity toEntity() {
    return AuthUserEntity(
      id: id ?? "",
      username: username ?? "",
      firstName: firstName ?? "",
      lastName: lastName ?? "",
      email: email ?? "",
      phone: phoneNumber ?? "",
      role: role ?? "",
      isVerified: isVerified ?? false,
      createdAt: createdAt ?? "",
    );
  }

  ProfileUserEntity toProfileEntity() {
    return ProfileUserEntity(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
    );
  }
}
