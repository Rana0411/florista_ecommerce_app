import 'package:json_annotation/json_annotation.dart';

import '../../../../../config/shared_models/categories/category_dto.dart';

part 'categories_response.g.dart';

@JsonSerializable()
class CategoriesResponse {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "categories")
  final List<CategoryDto>? categories;

  CategoriesResponse({
    this.message,
    this.categories,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}