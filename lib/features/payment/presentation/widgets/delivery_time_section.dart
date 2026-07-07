import 'package:florista_ecommerce_app/features/payment/presentation/widgets/date_time_helper.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/widgets/section_tile.dart';
import 'package:flutter/material.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/widgets/payment_section_container.dart';

class DeliveryTimeSection extends StatelessWidget {
  /// The estimated time the order will arrive.
  final DateTime estimatedArrival;

  /// Label shown before the time, e.g. "Instant", "Scheduled", "Express".
  final String deliveryLabel;

  const DeliveryTimeSection({
    super.key,
    required this.estimatedArrival,
    this.deliveryLabel = 'Instant',
  });

  @override
  Widget build(BuildContext context) {
    return PaymentSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('Delivery time'),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.access_time, size: 20, color: AppColors.black),
              const SizedBox(width: 8),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: '$deliveryLabel, ',
                    style: TextStyle(color: AppColors.black),
                    children: [
                      TextSpan(
                        text:
                            'Arrive by ${DeliveryTimeHelper.formatSmart(estimatedArrival)}',
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
