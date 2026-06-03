import 'package:json_annotation/json_annotation.dart';

part 'meta_data.g.dart';

@JsonSerializable()
class MetaData {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "limit")
  final int? limit;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "totalItems")
  final int? totalItems;

  MetaData({this.currentPage, this.limit, this.totalPages, this.totalItems});

  factory MetaData.fromJson(Map<String, dynamic> json) =>
      _$MetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$MetaDataToJson(this);
}
