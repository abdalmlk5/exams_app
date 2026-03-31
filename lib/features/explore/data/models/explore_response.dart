import 'package:exams_app/features/explore/data/models/subject_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'metadata.dart';

part 'explore_response.g.dart';

@JsonSerializable()
class ExploreResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "subjects")
  final List<SubjectModel>? subjects;

  ExploreResponse({this.message, this.metadata, this.subjects});

  factory ExploreResponse.fromJson(Map<String, dynamic> json) {
    return _$ExploreResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExploreResponseToJson(this);
  }
}
