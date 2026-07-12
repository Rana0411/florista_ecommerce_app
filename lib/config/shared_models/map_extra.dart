
import 'package:florista_ecommerce_app/features/auth/sign-up/domain/models/user_entity.dart';
import 'package:florista_ecommerce_app/features/map/domain/entities/shipping_address_entity.dart';

class MapExtra {
  final String orderId;
  final ShippingAddressEntity shippingAddressEntity;
  final UserEntity userEntity;

  MapExtra({
    required this.orderId,
    required this.shippingAddressEntity,
    required this.userEntity,
  });
}
