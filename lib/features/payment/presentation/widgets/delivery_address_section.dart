import 'package:florista_ecommerce_app/features/payment/presentation/widgets/section_tile.dart';
import 'package:flutter/material.dart';
import 'package:florista_ecommerce_app/config/shared_models/addresses/address_entity.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/widgets/add_address_button.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/widgets/address_tile.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/widgets/payment_section_container.dart';

class DeliveryAddressSection extends StatelessWidget {
  final List<AddressEntity> addresses;
  final String? selectedAddressId;
  final ValueChanged<String?> onChanged;
  final ValueChanged<AddressEntity> onEditAddress;
  final VoidCallback onAddAddress;

  const DeliveryAddressSection({
    super.key,
    required this.addresses,
    required this.selectedAddressId,
    required this.onChanged,
    required this.onEditAddress,
    required this.onAddAddress,
  });

  @override
  Widget build(BuildContext context) {
    return PaymentSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('Delivery address'),
          const SizedBox(height: 12),
          if (addresses.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'No saved addresses yet',
                style: TextStyle(
                  color: AppColors.lightGrey,
                  fontSize: FontSize.s14,
                ),
              ),
            )
          else
            ...addresses.map(
              (a) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AddressTile(
                  address: a,
                  selectedAddressId: selectedAddressId,
                  onChanged: onChanged,
                  onEditPressed: () => onEditAddress(a),
                ),
              ),
            ),
          AddAddressButton(onTap: onAddAddress),
        ],
      ),
    );
  }
}
