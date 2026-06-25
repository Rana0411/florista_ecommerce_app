import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:flutter/material.dart';

class EmptyOrdersWidget extends StatelessWidget {
  final String message;
  const EmptyOrdersWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 52,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.interFamily,
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.semiBold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your orders will appear here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.interFamily,
                fontSize: FontSize.s14,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
