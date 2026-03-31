import 'package:json_annotation/json_annotation.dart';

import 'exam_model.dart';

part 'exams_response.g.dart';

@JsonSerializable()
class ExamsResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "exams")
  final List<ExamModel>? exams;

  ExamsResponse({this.message, this.metadata, this.exams});

  factory ExamsResponse.fromJson(Map<String, dynamic> json) {
    return _$ExamsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExamsResponseToJson(this);
  }
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "numberOfPages")
  final int? numberOfPages;
  @JsonKey(name: "limit")
  final int? limit;

  Metadata({this.currentPage, this.numberOfPages, this.limit});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return _$MetadataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MetadataToJson(this);
  }
}
