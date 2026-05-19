import 'package:florista_ecommerce_app/features/home/domain/entities/best_seller_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'best_seller_dto.g.dart';

@JsonSerializable()
class BestSellerDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "imgCover")
  final String? imgCover;
  @JsonKey(name: "images")
  final List<String>? images;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "priceAfterDiscount")
  final int? priceAfterDiscount;
  @JsonKey(name: "discount")
  final int? discount;
  @JsonKey(name: "rateAvg")
  final int? rateAvg;
  @JsonKey(name: "rateCount")
  final int? rateCount;
  @JsonKey(name: "sold")
  final int? sold;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "category")
  final String? category;
  @JsonKey(name: "occasion")
  final String? occasion;
  @JsonKey(name: "isSuperAdmin")
  final bool? isSuperAdmin;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;
  @JsonKey(name: "__v")
  final int? v;
  @JsonKey(name: "id")
  final String? bestSellerId;

  BestSellerDto({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.discount,
    this.rateAvg,
    this.rateCount,
    this.sold,
    this.quantity,
    this.category,
    this.occasion,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.bestSellerId,
  });

  factory BestSellerDto.fromJson(Map<String, dynamic> json) =>
      _$BestSellerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BestSellerDtoToJson(this);

  BestSellerEntity toHomeDomain() =>
      BestSellerEntity(id: id, title: title, imgCover: imgCover, price: price);
}
