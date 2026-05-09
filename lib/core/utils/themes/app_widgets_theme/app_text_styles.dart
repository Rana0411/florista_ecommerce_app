import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:flutter/material.dart';
import '../../app_colors.dart';

abstract class AppTextStyles {
  static final light = TextTheme(
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: AppColors.grey,
      fontFamily: AppFonts.interFamily,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: AppColors.grey,
      fontFamily: AppFonts.interFamily,
    ),
  );

  static final dark = TextTheme(
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
      fontFamily: AppFonts.interFamily,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: AppColors.white,
      fontFamily: AppFonts.interFamily,
    ),
  );
}
