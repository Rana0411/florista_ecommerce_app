import 'package:florista_ecommerce_app/features/occasions/domain/models/occasion_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'occasion_dto_model.g.dart';

@JsonSerializable()
class OccasionDto {
  @JsonKey(name: "_id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "slug")
  final String slug;
  @JsonKey(name: "image")
  final String image;
  @JsonKey(name: "isSuperAdmin")
  final bool isSuperAdmin;
  @JsonKey(name: "createdAt")
  final DateTime createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime updatedAt;
  @JsonKey(name: "productsCount")
  final int productsCount;

  OccasionDto({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.isSuperAdmin,
    required this.createdAt,
    required this.updatedAt,
    required this.productsCount,
  });

  OccasionDto copyWith({
    String? id,
    String? name,
    String? slug,
    String? image,
    bool? isSuperAdmin,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? productsCount,
  }) => OccasionDto(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    image: image ?? this.image,
    isSuperAdmin: isSuperAdmin ?? this.isSuperAdmin,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    productsCount: productsCount ?? this.productsCount,
  );

  factory OccasionDto.fromJson(Map<String, dynamic> json) =>
      _$OccasionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OccasionDtoToJson(this);

  OccasionEntity toDomain(OccasionDto dto) => OccasionEntity(name: dto.name);
}
