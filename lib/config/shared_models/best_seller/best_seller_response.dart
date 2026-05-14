import 'package:florista_ecommerce_app/config/shared_models/best_seller/best_seller_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'best_seller_response.g.dart';

@JsonSerializable()
class BestSellerResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "bestSeller")
  final List<BestSellerDto>? bestSeller;

  BestSellerResponse({this.message, this.bestSeller});

  factory BestSellerResponse.fromJson(Map<String, dynamic> json) =>
      _$BestSellerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BestSellerResponseToJson(this);
}
