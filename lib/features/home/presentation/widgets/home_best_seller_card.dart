import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/best_seller_entity.dart';
import 'package:flutter/material.dart';

class HomeBestSellerCard extends StatelessWidget {
  const HomeBestSellerCard({super.key, required this.bestSeller});
  final BestSellerEntity bestSeller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {
          //* Navigate to best seller
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              width: 131,
              height: 151,
              bestSeller.imgCover ?? '',
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image_not_supported_outlined,
                  size: 151,
                );
              },
            ),
            SizedBox(
              width: 131,
              child: Text(
                bestSeller.title ?? '',
                style: TextStyle(
                  fontWeight: FontWeightManager.regular,
                  color: AppColors.black,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
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
