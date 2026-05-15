// To parse this JSON data, do
//
//     final allOccasionResponseModel = allOccasionResponseModelFromMap(jsonString);

import 'package:florista_ecommerce_app/features/occasions/data/models/occasion_dto/occasion_dto_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_occasion_response_model.g.dart';

@JsonSerializable()
class AllOccasionResponseModel {
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "metadata")
  final Metadata metadata;
  @JsonKey(name: "occasions")
  final List<OccasionDto> occasions;

  AllOccasionResponseModel({
    required this.message,
    required this.metadata,
    required this.occasions,
  });

  AllOccasionResponseModel copyWith({
    String? message,
    Metadata? metadata,
    List<OccasionDto>? occasions,
  }) => AllOccasionResponseModel(
    message: message ?? this.message,
    metadata: metadata ?? this.metadata,
    occasions: occasions ?? this.occasions,
  );

  factory AllOccasionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AllOccasionResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllOccasionResponseModelToJson(this);
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "currentPage")
  final int currentPage;
  @JsonKey(name: "limit")
  final int limit;
  @JsonKey(name: "totalPages")
  final int totalPages;
  @JsonKey(name: "totalItems")
  final int totalItems;

  Metadata({
    required this.currentPage,
    required this.limit,
    required this.totalPages,
    required this.totalItems,
  });

  Metadata copyWith({
    int? currentPage,
    int? limit,
    int? totalPages,
    int? totalItems,
  }) => Metadata(
    currentPage: currentPage ?? this.currentPage,
    limit: limit ?? this.limit,
    totalPages: totalPages ?? this.totalPages,
    totalItems: totalItems ?? this.totalItems,
  );

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
