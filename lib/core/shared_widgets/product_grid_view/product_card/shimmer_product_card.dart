import 'package:florista_ecommerce_app/core/shared_widgets/app_shimmer.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Container(
        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),

            borderRadius: BorderRadius.circular(18)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.grey),

                ),
              ),
            ),

            const SizedBox(height: 10),

            Container(height: 14, width: 100, color: AppColors.primary),

            const SizedBox(height: 10),

            Container(height: 14, width: 140, color: AppColors.white),

            const SizedBox(height: 12),

            Container(
              height: 44,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
