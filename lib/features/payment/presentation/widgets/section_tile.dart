import 'package:flutter/material.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';

/// Bold section header used at the top of each payment section card.
class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: FontSize.s16,
        fontWeight: FontWeightManager.bold,
        color: AppColors.black,
      ),
    );
  }
}
