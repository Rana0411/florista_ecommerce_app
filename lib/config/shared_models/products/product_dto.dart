import 'package:json_annotation/json_annotation.dart';
part 'product_dto.g.dart';

@JsonSerializable()
class Product {
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
  final int sold;
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
  @JsonKey(name: "id")
  final String productId;

  Product({
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
    required this.sold,
    required this.quantity,
    required this.category,
    required this.occasion,
    required this.isSuperAdmin,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.productId,
  });

  Product copyWith({
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
    String? productId,
  }) => Product(
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
    productId: productId ?? this.productId,
  );

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
