import 'package:florista_ecommerce_app/core/shared_widgets/app_shimmer.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTabBarShimmer extends StatelessWidget {
  const AppTabBarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap the entire row in your unified shimmer
    return AppShimmer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics:
              const NeverScrollableScrollPhysics(), // Prevent user scrolling while loading
          child: Row(
            children: List.generate(4, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shimmer for the Tab Text
                    Container(
                      width: 90,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Shimmer for the Tab Indicator
                    Container(
                      width: 90,
                      height: 3,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
