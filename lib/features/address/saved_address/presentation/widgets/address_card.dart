import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/address_entity.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.address,
    required this.onDelete,
    required this.onEdit,
  });

  final AddressEntity address;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.hintColor.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.location_on_outlined, color: AppColors.black),

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.city ?? '',
                  style: TextStyle(
                    fontFamily: AppFonts.interFamily,
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.semiBold,
                    color: AppColors.black,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  address.street ?? '',
                  style: TextStyle(
                    fontFamily: AppFonts.interFamily,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                    color: AppColors.lightGrey,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: onDelete,
            icon: Icon(Icons.delete_outline, color: AppColors.error),
          ),

          IconButton(
            onPressed: onEdit,
            icon: Icon(Icons.edit_outlined, color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
