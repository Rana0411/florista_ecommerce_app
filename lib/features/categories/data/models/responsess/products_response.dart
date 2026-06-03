import 'package:json_annotation/json_annotation.dart';

import '../product_dto.dart';

part 'products_response.g.dart';

@JsonSerializable()
class ProductsResponse {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'products')
  final List<ProductDto>? products;

  ProductsResponse({this.message, this.products});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseToJson(this);
}
