import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/categories-entity.dart';

part 'categories_dto.g.dart';

@JsonSerializable()
class CategoryDto {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "slug")
  final String? slug;

  @JsonKey(name: "image")
  final String? image;

  @JsonKey(name: "productsCount")
  final int? productsCount;

  CategoryDto({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.productsCount,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);

  CategoryEntity toDomain() {
    return CategoryEntity(
      id: id ?? "",
      name: name ?? "",
      image: image ?? "",
      productsCount: productsCount ?? 0,
    );
  }
}