import 'package:flutter/material.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/widgets/payment_section_container.dart';

class GiftSection extends StatelessWidget {
  final bool isGift;
  final bool enabled;
  final ValueChanged<bool> onChanged;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  const GiftSection({
    super.key,
    required this.isGift,
    this.enabled = true,
    required this.onChanged,
    required this.nameController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    final bool showGiftFields = isGift && enabled;

    return PaymentSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Switch(
                value: isGift && enabled,
                activeColor: AppColors.primary,
                onChanged: enabled ? onChanged : null,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'It is a gift',
                  style: TextStyle(
                    fontWeight: FontWeightManager.semiBold,
                    fontSize: FontSize.s16,
                    color: enabled ? AppColors.black : AppColors.lightGrey,
                  ),
                ),
              ),
            ],
          ),
          if (!enabled)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Not available with cash on delivery',
                style: TextStyle(
                  fontSize: FontSize.s12,
                  color: AppColors.lightGrey,
                ),
              ),
            ),
          if (showGiftFields) ...[
            const SizedBox(height: 12),
            _label('Name'),
            TextField(
              controller: nameController,
              decoration: _inputDecoration('Enter the name'),
            ),
            const SizedBox(height: 12),
            _label('Phone number'),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: _inputDecoration('Enter the phone number'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6, top: 6),
    child: Text(
      text,
      style: TextStyle(fontSize: FontSize.s12, color: AppColors.lightGrey),
    ),
  );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: AppColors.veryLightGrey.withValues(alpha: 0.3),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
  );
}
