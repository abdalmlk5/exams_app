import 'package:json_annotation/json_annotation.dart';
import '../../models/user_model.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponseModel {
  final String message;
  final String? token;
  final UserModel user;

  AuthResponseModel({required this.message, this.token, required this.user});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);
}
