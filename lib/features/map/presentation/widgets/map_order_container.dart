import 'package:florista_ecommerce_app/features/auth/sign-up/domain/models/user_entity.dart';
import 'package:florista_ecommerce_app/features/map/domain/entities/shipping_address_entity.dart';
import 'package:flutter/material.dart';
import 'package:florista_ecommerce_app/features/map/presentation/widgets/map_order_card.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';

class MapOrderContainer extends StatelessWidget {
  const MapOrderContainer({
    super.key,
    required this.shippingAddressEntity,
    required this.userEntity,
  });
  final ShippingAddressEntity shippingAddressEntity;
  final UserEntity userEntity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        width: .infinity,
        child: Column(
          crossAxisAlignment: .start,
          spacing: 24,
          children: [
            SizedBox(height: 3),
            Text(
              S.current.pickupAdderss,
              style: Theme.of(context).textTheme.bodySmall,
            ),

            Text(
              S.current.userAddress,
              style: Theme.of(context).textTheme.bodySmall,
            ),

            MapOrderCard(
              image: userEntity.photo,
              name: '${userEntity.firstName} ${userEntity.lastName}',
              address: shippingAddressEntity.city,
              phone: userEntity.phone,
            ),
          ],
        ),
      ),
    );
  }
}
