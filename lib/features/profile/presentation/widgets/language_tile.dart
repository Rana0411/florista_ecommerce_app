import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/app_language/bottom_sheet.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({super.key, required Null Function() onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Icon(Icons.translate),
          Text(
            S.of(context).language,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 13,
              fontWeight: FontWeightManager.regular,
            ),
          ),
          Spacer(),
          TextButton(
            onPressed: () {
              // Show language selection bottom sheet
              showModalBottomSheet(
                context: context,
                backgroundColor: AppColors.transparent,
                builder: (context) => const LanguageBottomSheet(),
              );
            },
            child: Text(
              S.of(context).changeLanguage,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: FontSize.s12,
                fontWeight: FontWeightManager.regular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
