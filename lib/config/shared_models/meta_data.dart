import 'package:json_annotation/json_annotation.dart';
part 'meta_data.g.dart';

@JsonSerializable()
class MetaData {
  @JsonKey(name: "currentPage")
  final int currentPage;
  @JsonKey(name: "limit")
  final int limit;
  @JsonKey(name: "totalPages")
  final int totalPages;
  @JsonKey(name: "totalItems")
  final int totalItems;

  MetaData({
    required this.currentPage,
    required this.limit,
    required this.totalPages,
    required this.totalItems,
  });

  MetaData copyWith({
    int? currentPage,
    int? limit,
    int? totalPages,
    int? totalItems,
  }) => MetaData(
    currentPage: currentPage ?? this.currentPage,
    limit: limit ?? this.limit,
    totalPages: totalPages ?? this.totalPages,
    totalItems: totalItems ?? this.totalItems,
  );

  factory MetaData.fromJson(Map<String, dynamic> json) =>
      _$MetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$MetaDataToJson(this);
}
