import 'package:florista_ecommerce_app/features/cart/domain/models/cart_item_entity.dart';

class CartEntity {
  final String id;

  final String user;

  final List<CartItemEntity> cartItems;

  final List<dynamic> appliedCoupons;

  final num discount;

  final num totalPrice;

  final num totalPriceAfterDiscount;

  CartEntity({
    required this.cartItems,
    required this.discount,
    required this.totalPrice,
    required this.totalPriceAfterDiscount,
    required this.id,
    required this.user,
    required this.appliedCoupons,
  });
}
