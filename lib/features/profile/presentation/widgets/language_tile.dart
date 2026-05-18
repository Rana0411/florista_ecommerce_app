import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Icon(Icons.translate),
          Text(
            "Language",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 13,
              fontWeight: FontWeightManager.regular,
            ),
          ),
          Spacer(),
          TextButton(
            onPressed: () {},
            child: Text(
              "English",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 11,
                fontWeight: FontWeightManager.regular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
