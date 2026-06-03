import 'package:florista_ecommerce_app/config/shared_models/products/product_dto.dart';
import 'package:florista_ecommerce_app/features/cart/domain/models/cart_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_dto.g.dart';

@JsonSerializable()
class CartItemDto {
  @JsonKey(name: "product")
  Product? product;
  @JsonKey(name: "price")
  int? price = 0;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "_id")
  String? id = "";

  CartItemDto({required this.product, this.price, this.quantity, this.id});

  CartItemDto copyWith({
    Product? product,
    int? price,
    int? quantity,
    String? id,
  }) => CartItemDto(
    product: product ?? this.product,
    price: price ?? this.price,
    quantity: quantity ?? this.quantity,
    id: id ?? this.id,
  );

  factory CartItemDto.fromJson(Map<String, dynamic> json) =>
      _$CartItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemDtoToJson(this);

  CartItemEntity toEntity(CartItemDto cartItemDto) {
    return CartItemEntity(
      product:
          cartItemDto.product ??
          Product(
            id: '',
            title: '',
            slug: '',
            description: '',
            imgCover: '',
            images: [],
            price: 0,
            priceAfterDiscount: 0,
            discount: 0,
            rateAvg: 0,
            rateCount: 0,
            sold: 0,
            quantity: 0,
            category: '',
            occasion: '',
            isSuperAdmin: false,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            v: 0,
            productId: '',
          ),
      price: cartItemDto.price ?? 0,
      quantity: cartItemDto.quantity ?? 0,
      id: cartItemDto.id ?? '',
    );
  }
}
