import 'package:florista_ecommerce_app/features/cart/domain/models/cart_entity.dart';
import 'package:florista_ecommerce_app/features/cart/domain/models/cart_item_entity.dart';
import 'package:florista_ecommerce_app/features/cart/domain/models/cart_response_entity.dart';

abstract class CartConstants {
  static const double deliveryFee = 10;
}

abstract class CartHelpers {
  static String productImageUrl(String imgCover) {
    if (imgCover.isEmpty) return '';
    if (imgCover.startsWith('http')) return imgCover;
    const host = 'https://flower.elevateegy.com';
    final path = imgCover.startsWith('/') ? imgCover : '/$imgCover';
    return '$host$path';
  }

  static num itemsSubtotal(List<CartItemEntity> items) {
    return items.fold<num>(
      0,
      (sum, item) => sum + item.price * item.quantity,
    );
  }

  static CartResponseEntity rebuildWithItems(
    CartResponseEntity current,
    List<CartItemEntity> items,
  ) {
    final subtotal = itemsSubtotal(items);
    final cart = current.cart;

    return current.copyWith(
      numOfCartItems: items.length,
      cart: CartEntity(
        id: cart.id,
        user: cart.user,
        cartItems: items,
        appliedCoupons: cart.appliedCoupons,
        discount: cart.discount,
        totalPrice: subtotal,
        totalPriceAfterDiscount: subtotal - cart.discount,
      ),
    );
  }
}
