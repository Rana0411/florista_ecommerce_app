import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/order_entity.dart';

class CompletedOrderCard extends StatelessWidget {
  final OrderEntity order;
  final VoidCallback onReorder;

  const CompletedOrderCard({
    super.key,
    required this.order,
    required this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    final item = order.firstItem;
    final deliveredDate = order.deliveredAt ?? order.createdAt;
    final formattedDate = DateFormat('dMMM yyyy').format(deliveredDate);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: item?.imageUrl != null && item!.imageUrl.isNotEmpty
                ? Image.network(
                    item.imageUrl,
                    width: 80,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _placeholder(),
                  )
                : _placeholder(),
          ),
          const SizedBox(width: 12),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item?.productName ?? 'Order',
                  style: TextStyle(
                    fontFamily: AppFonts.interFamily,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.semiBold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'EGP ${order.totalPrice.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontFamily: AppFonts.interFamily,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Delivered on $formattedDate',
                  style: TextStyle(
                    fontFamily: AppFonts.interFamily,
                    fontSize: FontSize.s12,
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onReorder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Reorder',
                      style: TextStyle(
                        fontFamily: AppFonts.interFamily,
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() => Container(
        width: 80,
        height: 90,
        decoration: BoxDecoration(
          color: const Color(0xffFCE4EC),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.local_florist_outlined,
            color: AppColors.primary, size: 36),
      );
}
