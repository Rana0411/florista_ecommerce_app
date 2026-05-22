import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class CartSummarySection extends StatelessWidget {
  const CartSummarySection({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
  });

  final num subtotal;
  final num deliveryFee;
  final num total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          _SummaryRow(
            label: 'Sub Total',
            value: '${S.current.EGB} $subtotal',
          ),
          const SizedBox(height: 8),
          _SummaryRow(
            label: 'Delivery Fee',
            value: '${S.current.EGB} $deliveryFee',
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE8E8E8)),
          const SizedBox(height: 12),
          _SummaryRow(
            label: 'Total',
            value: '${S.current.EGB} $total',
            isBold: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  final String label;
  final String value;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: FontSize.s16,
      fontWeight: isBold ? FontWeightManager.bold : FontWeightManager.regular,
      color: AppColors.black,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}
