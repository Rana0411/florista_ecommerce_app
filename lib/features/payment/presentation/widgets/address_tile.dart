// lib/features/payment/presentation/widgets/address_tile.dart
import 'package:florista_ecommerce_app/config/shared_models/addresses/address_entity.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:flutter/material.dart';

class AddressTile extends StatelessWidget {
  final AddressEntity address;
  final String? selectedAddressId;
  final ValueChanged<String?> onChanged;
  final VoidCallback onEditPressed;

  const AddressTile({
    super.key,
    required this.address,
    required this.selectedAddressId,
    required this.onChanged,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool selected = selectedAddressId == address.id;
    return LayoutBuilder(
      builder: (context, constraints) {
        final double pad = (constraints.maxWidth * 0.03).clamp(8.0, 14.0);
        return InkWell(
          onTap: () => onChanged(address.id),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: pad, vertical: pad),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: selected ? AppColors.primary : Colors.transparent,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: selected ? AppColors.primary : AppColors.lightGrey,
                  size: 22,
                ),
                SizedBox(width: pad),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.label,
                        style: TextStyle(
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.semiBold,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        address.shortLine,
                        style: TextStyle(
                          fontSize: FontSize.s12,
                          color: AppColors.lightGrey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  onPressed: onEditPressed,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
