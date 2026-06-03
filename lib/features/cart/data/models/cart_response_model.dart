import 'package:florista_ecommerce_app/features/cart/data/models/cart_dto.dart';
import 'package:florista_ecommerce_app/features/cart/domain/models/cart_entity.dart';
import 'package:florista_ecommerce_app/features/cart/domain/models/cart_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_response_model.g.dart';

@JsonSerializable()
class CartResponseModel {
  @JsonKey(name: "numOfCartItems")
  final int? numOfCartItems;
  @JsonKey(name: "cart")
  final CartDto? cart;

  CartResponseModel({this.numOfCartItems, this.cart});

  CartResponseModel copyWith({int? numOfCartItems, CartDto? cart}) =>
      CartResponseModel(
        numOfCartItems: numOfCartItems ?? this.numOfCartItems,
        cart: cart ?? this.cart,
      );

  factory CartResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CartResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseModelToJson(this);

  CartResponseEntity toEntity() {
    return CartResponseEntity(
      numOfCartItems: numOfCartItems ?? 0,
      cart: cart != null
          ? cart!.toEntity(cart!)
          : CartEntity(
              id: '',
              user: '',
              cartItems: [],
              appliedCoupons: [],
              discount: 0,
              totalPrice: 0,
              totalPriceAfterDiscount: 0,
            ),
    );
  }
}
