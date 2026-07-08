import 'package:florista_ecommerce_app/features/payment/presentation/widgets/section_tile.dart';
import 'package:flutter/material.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/widgets/payment_method_tile.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/widgets/payment_section_container.dart';

class PaymentMethodSection extends StatelessWidget {
  final String selectedMethod;
  final ValueChanged<String?> onChanged;

  const PaymentMethodSection({
    super.key,
    required this.selectedMethod,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PaymentSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('Payment method'),
          PaymentMethodTile(
            title: 'Cash on delivery',
            value: 'cod',
            groupValue: selectedMethod,
            onChanged: onChanged,
          ),
          Divider(color: AppColors.veryLightGrey, height: 1),
          PaymentMethodTile(
            title: 'Credit card',
            value: 'card',
            groupValue: selectedMethod,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
