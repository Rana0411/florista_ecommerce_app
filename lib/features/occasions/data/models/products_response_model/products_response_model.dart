// To parse this JSON data, do
//
//     final productsResponseModel = productsResponseModelFromMap(jsonString);

import 'package:florista_ecommerce_app/features/occasions/data/models/product_dto/product_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_response_model.g.dart';

@JsonSerializable()
class ProductsResponseModel {
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "metadata")
  final Metadata metadata;
  @JsonKey(name: "products")
  final List<ProductDto> products;

  ProductsResponseModel({
    required this.message,
    required this.metadata,
    required this.products,
  });

  ProductsResponseModel copyWith({
    String? message,
    Metadata? metadata,
    List<ProductDto>? products,
  }) => ProductsResponseModel(
    message: message ?? this.message,
    metadata: metadata ?? this.metadata,
    products: products ?? this.products,
  );

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseModelToJson(this);
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "currentPage")
  final int currentPage;
  @JsonKey(name: "totalPages")
  final int totalPages;
  @JsonKey(name: "limit")
  final int limit;
  @JsonKey(name: "totalItems")
  final int totalItems;

  Metadata({
    required this.currentPage,
    required this.totalPages,
    required this.limit,
    required this.totalItems,
  });

  Metadata copyWith({
    int? currentPage,
    int? totalPages,
    int? limit,
    int? totalItems,
  }) => Metadata(
    currentPage: currentPage ?? this.currentPage,
    totalPages: totalPages ?? this.totalPages,
    limit: limit ?? this.limit,
    totalItems: totalItems ?? this.totalItems,
  );

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
