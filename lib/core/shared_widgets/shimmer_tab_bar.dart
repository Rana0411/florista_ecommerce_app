import 'package:florista_ecommerce_app/core/shared_widgets/tab_indicator_painter.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomTabBarShimmer extends StatelessWidget {
  const CustomTabBarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 4,
        separatorBuilder: (context, index) => const SizedBox(width: 24),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // tab text shimmer
                Container(
                  width: 70,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                const SizedBox(height: 6),

                // trapezoid indicator shimmer
                CustomPaint(
                  size: const Size(45, 3),
                  painter: TabIndicatorPainter(color: AppColors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
