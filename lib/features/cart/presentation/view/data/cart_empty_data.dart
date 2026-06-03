import 'package:florista_ecommerce_app/features/cart/domain/models/cart_entity.dart';
import 'package:florista_ecommerce_app/features/cart/domain/models/cart_response_entity.dart';

abstract class CartEmptyData {
  static CartResponseEntity get response => CartResponseEntity(
        numOfCartItems: 0,
        cart: CartEntity(
          id: '',
          user: '',
          cartItems: const [],
          appliedCoupons: const [],
          discount: 0,
          totalPrice: 0,
          totalPriceAfterDiscount: 0,
        ),
      );
}
