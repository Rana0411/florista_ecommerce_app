import 'package:florista_ecommerce_app/config/models/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {
  @JsonKey(name: "_id")
  final String id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "slug")
  final String slug;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "imgCover")
  final String imgCover;
  @JsonKey(name: "images")
  final List<String> images;
  @JsonKey(name: "price")
  final int price;
  @JsonKey(name: "priceAfterDiscount")
  final int priceAfterDiscount;
  @JsonKey(name: "discount")
  final int discount;
  @JsonKey(name: "rateAvg")
  final int rateAvg;
  @JsonKey(name: "rateCount")
  final int rateCount;
  @JsonKey(name: "sold")
  final int? sold;
  @JsonKey(name: "quantity")
  final int quantity;
  @JsonKey(name: "category")
  final String category;
  @JsonKey(name: "occasion")
  final String occasion;
  @JsonKey(name: "isSuperAdmin")
  final bool isSuperAdmin;
  @JsonKey(name: "createdAt")
  final DateTime createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime updatedAt;
  @JsonKey(name: "__v")
  final int v;
  @JsonKey(name: "favoriteId")
  final dynamic favoriteId;
  @JsonKey(name: "isInWishlist")
  final bool isInWishlist;

  ProductDto({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.discount,
    required this.rateAvg,
    required this.rateCount,
    this.sold,
    required this.quantity,
    required this.category,
    required this.occasion,
    required this.isSuperAdmin,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.favoriteId,
    required this.isInWishlist,
  });

  ProductDto copyWith({
    String? id,
    String? title,
    String? slug,
    String? description,
    String? imgCover,
    List<String>? images,
    int? price,
    int? priceAfterDiscount,
    int? discount,
    int? rateAvg,
    int? rateCount,
    int? sold,
    int? quantity,
    String? category,
    String? occasion,
    bool? isSuperAdmin,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    dynamic favoriteId,
    bool? isInWishlist,
  }) => ProductDto(
    id: id ?? this.id,
    title: title ?? this.title,
    slug: slug ?? this.slug,
    description: description ?? this.description,
    imgCover: imgCover ?? this.imgCover,
    images: images ?? this.images,
    price: price ?? this.price,
    priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
    discount: discount ?? this.discount,
    rateAvg: rateAvg ?? this.rateAvg,
    rateCount: rateCount ?? this.rateCount,
    sold: sold ?? this.sold,
    quantity: quantity ?? this.quantity,
    category: category ?? this.category,
    occasion: occasion ?? this.occasion,
    isSuperAdmin: isSuperAdmin ?? this.isSuperAdmin,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    v: v ?? this.v,
    favoriteId: favoriteId ?? this.favoriteId,
    isInWishlist: isInWishlist ?? this.isInWishlist,
  );

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);

  ProductEntity toDomain(ProductDto dto) {
    return ProductEntity(
      name: '',
      price: dto.price,
      priceAfterDiscount: dto.priceAfterDiscount,
      discount: dto.discount,
      imageCover: dto.imgCover,
    );
  }
}
