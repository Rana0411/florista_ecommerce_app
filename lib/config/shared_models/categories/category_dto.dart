import 'package:florista_ecommerce_app/features/categories/domain/entities/categories_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/category_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';

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

  CategoryDto({this.id, this.name, this.slug, this.image, this.productsCount});

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);

  CategoriesEntity toDomain() => CategoriesEntity(
    id: id ?? '',
    name: name ?? '',
    image: image ?? '',
    productsCount: productsCount ?? 0,
  );

  CategoryEntity toHomeDomain() =>
      CategoryEntity(id: id, name: name, image: image);
}
