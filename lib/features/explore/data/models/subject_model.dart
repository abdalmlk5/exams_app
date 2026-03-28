import 'package:json_annotation/json_annotation.dart';

part 'subject_model.g.dart';

@JsonSerializable()
class SubjectModel {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "icon")
  final String? icon;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  SubjectModel({this.id, this.name, this.icon, this.createdAt});

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return _$SubjectModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubjectModelToJson(this);
  }
}
