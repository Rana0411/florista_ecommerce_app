import 'package:florista_ecommerce_app/config/shared_models/occasions/occasion_dto.dart';
import 'package:florista_ecommerce_app/config/shared_models/meta_data.dart';

import 'package:json_annotation/json_annotation.dart';

part 'occasions_response.g.dart';

@JsonSerializable()
class OccasionsResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final MetaData? metadata;
  @JsonKey(name: "occasions")
  final List<OccasionDto>? occasions;

  OccasionsResponse({this.message, this.metadata, this.occasions});

  factory OccasionsResponse.fromJson(Map<String, dynamic> json) =>
      _$OccasionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OccasionsResponseToJson(this);
}
