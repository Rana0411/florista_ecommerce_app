import 'package:florista_ecommerce_app/features/auth/sign-up/domain/models/user_entity.dart';
import 'package:florista_ecommerce_app/features/map/domain/entities/shipping_address_entity.dart';

class OrderEntity {
  final String id;
  final UserEntity user;
  final ShippingAddressEntity shippingAddress;
  final double totalPrice;

  OrderEntity({
    required this.id,
    required this.user,
    required this.shippingAddress,
    required this.totalPrice,
  });
}
