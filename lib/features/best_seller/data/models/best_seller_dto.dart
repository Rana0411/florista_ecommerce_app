import 'package:json_annotation/json_annotation.dart';
import 'package:florista_ecommerce_app/features/categories/data/models/product_dto.dart';

part 'best_seller_dto.g.dart';

@JsonSerializable()
class BestSellerDto {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'bestSeller')
  final List<ProductDto>? bestSeller;

  BestSellerDto({this.message, this.bestSeller});

  factory BestSellerDto.fromJson(Map<String, dynamic> json) =>
      _$BestSellerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BestSellerDtoToJson(this);
}