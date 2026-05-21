import 'package:florista_ecommerce_app/features/cart/data/models/cart_item_dto.dart';
import 'package:florista_ecommerce_app/features/cart/domain/models/cart_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_dto.g.dart';

@JsonSerializable()
class CartDto {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "user")
  final String? user;

  @JsonKey(name: "cartItems")
  final List<CartItemDto>? cartItems;

  @JsonKey(name: "appliedCoupons")
  final List<dynamic>? appliedCoupons;

  @JsonKey(name: "discount")
  final int? discount;

  @JsonKey(name: "totalPrice")
  final num? totalPrice;

  @JsonKey(name: "totalPriceAfterDiscount")
  final num? totalPriceAfterDiscount;

  CartDto({
    this.id,
    this.user,
    this.cartItems,
    this.appliedCoupons,
    this.discount,
    this.totalPrice,
    this.totalPriceAfterDiscount,
  });

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CartDtoToJson(this);

  CartEntity toEntity(CartDto cartDto) {
    return CartEntity(
      id: cartDto.id ?? '',
      user: cartDto.user ?? '',
      cartItems:
          cartDto.cartItems?.map((item) => item.toEntity(item)).toList() ?? [],
      appliedCoupons: cartDto.appliedCoupons ?? [],
      discount: cartDto.discount ?? 0,
      totalPrice: cartDto.totalPrice ?? 0,
      totalPriceAfterDiscount: cartDto.totalPriceAfterDiscount ?? 0,
    );
  }
}
