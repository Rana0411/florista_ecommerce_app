import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/product_entity.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'slug')
  final String? slug;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'imgCover')
  final String? imgCover;

  @JsonKey(name: 'images')
  final List<String>? images;

  /// Original price before discount
  @JsonKey(name: 'price')
  final int? price;

  /// Final price after discount is applied
  @JsonKey(name: 'priceAfterDiscount')
  final int? priceAfterDiscount;

  /// Absolute discount amount in currency (NOT a percentage)
  @JsonKey(name: 'discount')
  final int? discountAmount;

  @JsonKey(name: 'rateAvg')
  final num? rateAvg;

  @JsonKey(name: 'rateCount')
  final int? rateCount;

  @JsonKey(name: 'sold')
  final int? sold;

  @JsonKey(name: 'quantity')
  final int? quantity;

  @JsonKey(name: 'category')
  final String? categoryId;

  @JsonKey(name: 'occasion')
  final String? occasionId;

  @JsonKey(name: 'favoriteId')
  final String? favoriteId;

  @JsonKey(name: 'isInWishlist')
  final bool? isInWishlist;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  ProductDto({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.discountAmount,
    this.rateAvg,
    this.rateCount,
    this.sold,
    this.quantity,
    this.categoryId,
    this.occasionId,
    this.favoriteId,
    this.isInWishlist,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);

  ProductEntity toDomain() {
    return ProductEntity(
      id: id ?? '',
      name: title ?? '',
      description: description ?? '',
      image: imgCover ?? '',
      images: images ?? [],
      price: (priceAfterDiscount ?? price ?? 0).toDouble(),
      originalPrice: (price ?? 0).toDouble(),
      discountAmount: discountAmount ?? 0,
      rateAvg: (rateAvg ?? 0).toDouble(),
      rateCount: rateCount ?? 0,
      sold: sold ?? 0,
      quantity: quantity ?? 0,
      categoryId: categoryId ?? '',
      occasionId: occasionId ?? '',
      isInWishlist: isInWishlist ?? false,
      createdAt: createdAt ?? DateTime.now(),
    );
  }
}
