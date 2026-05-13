import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeCategory extends StatelessWidget {
  const HomeCategory({
    super.key,
    required this.categoryName,
    required this.imageUrl,
  });
  final String categoryName;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Image.network(imageUrl),
          Text(
            categoryName,
            style: TextStyle(
              fontWeight: FontWeight(400),
              fontSize: 14,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
