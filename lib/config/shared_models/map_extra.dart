
import 'package:florista_ecommerce_app/features/auth/sign-up/domain/models/user_entity.dart';
import 'package:florista_ecommerce_app/features/map/domain/entities/shipping_address_entity.dart';

class MapExtra {
  final ShippingAddressEntity shippingAddressEntity;
  final UserEntity userEntity;

  MapExtra({
    required this.shippingAddressEntity,
    required this.userEntity,
  });
}
