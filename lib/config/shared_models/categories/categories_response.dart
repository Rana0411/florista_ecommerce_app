import 'package:florista_ecommerce_app/config/shared_models/categories/category_dto.dart';
import 'package:florista_ecommerce_app/config/shared_models/meta_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categories_response.g.dart';

@JsonSerializable()
class CategoriesResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final MetaData? metadata;
  @JsonKey(name: "categories")
  final List<CategoryDto>? categories;

  CategoriesResponse({this.message, this.metadata, this.categories});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}
