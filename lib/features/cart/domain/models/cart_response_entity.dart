import 'package:florista_ecommerce_app/features/cart/domain/models/cart_entity.dart';

class CartResponseEntity {
  final int numOfCartItems;
  final CartEntity cart;

  CartResponseEntity({required this.numOfCartItems, required this.cart});

  CartResponseEntity copyWith({int? numOfCartItems, CartEntity? cart}) =>
      CartResponseEntity(
        numOfCartItems: numOfCartItems ?? this.numOfCartItems,
        cart: cart ?? this.cart,
      );
}
