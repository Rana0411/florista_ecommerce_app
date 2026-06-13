import 'package:flutter/material.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/widgets/payment_section_container.dart';

class OrderSummarySection extends StatelessWidget {
  final double subTotal;
  final double deliveryFee;

  const OrderSummarySection({
    super.key,
    required this.subTotal,
    required this.deliveryFee,
  });

  double get total => subTotal + deliveryFee;

  @override
  Widget build(BuildContext context) {
    return PaymentSectionContainer(
      child: Column(
        children: [
          _summaryRow('Sub Total', subTotal),
          const SizedBox(height: 6),
          _summaryRow('Delivery Fee', deliveryFee),
          const Divider(height: 20),
          _summaryRow('Total', total, isBold: true),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, double value, {bool isBold = false}) {
    final style = TextStyle(
      fontSize: FontSize.s14,
      color: AppColors.black,
      fontWeight: isBold ? FontWeightManager.bold : FontWeightManager.regular,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text('${value.toStringAsFixed(0)}\$', style: style),
      ],
    );
  }
}
