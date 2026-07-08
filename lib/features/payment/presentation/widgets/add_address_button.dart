// lib/features/payment/presentation/widgets/add_address_button.dart
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:flutter/material.dart';

class AddAddressButton extends StatelessWidget {
  final VoidCallback onTap;
  const AddAddressButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(Icons.add, color: AppColors.primary, size: 18),
        label: Text(
          'Add new',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeightManager.semiBold,
            fontSize: FontSize.s14,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.veryLightGrey),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }
}
