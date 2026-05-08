import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:flutter/material.dart';
import '../../app_colors.dart';

abstract class AppButtonTheme {
  static final light = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      disabledBackgroundColor: AppColors.lightGrey,
      disabledForegroundColor: AppColors.white,
      padding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      textStyle: TextStyle(
        color: AppColors.black,
        fontSize: 16,
        fontFamily: AppFonts.interFamily,
      ),
    ),
  );

  static final dark = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      disabledBackgroundColor: AppColors.lightGrey,
      disabledForegroundColor: AppColors.white,
      padding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      textStyle: TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontFamily: AppFonts.interFamily,
      ),
    ),
  );
}
