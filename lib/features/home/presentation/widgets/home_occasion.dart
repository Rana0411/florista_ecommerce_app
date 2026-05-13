import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/occasion_entity.dart';
import 'package:flutter/material.dart';

class HomeOccasion extends StatelessWidget {
  const HomeOccasion({super.key, required this.occasion});
  final OccasionEntity occasion;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(occasion.image ?? ''),
            Text(
              occasion.name ?? '',
              style: TextStyle(
                fontWeight: FontWeightManager.medium,
                fontSize: 14,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
