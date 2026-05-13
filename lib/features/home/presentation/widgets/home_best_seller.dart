import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/best_seller_entity.dart';
import 'package:flutter/material.dart';

class HomeBestSeller extends StatelessWidget {
  const HomeBestSeller({super.key, required this.bestSeller});
  final BestSellerEntity bestSeller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(bestSeller.imgCover ?? ''),
            Text(
              bestSeller.title ?? '',
              style: TextStyle(
                fontWeight: FontWeightManager.regular,
                color: AppColors.black,
                fontSize: 12,
              ),
            ),
            Text(
              '${bestSeller.price} EGP',
              style: TextStyle(
                fontWeight: FontWeightManager.medium,
                color: AppColors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
