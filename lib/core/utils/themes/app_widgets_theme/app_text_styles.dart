import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/core/utils/themes/app_widgets_theme/text_style_manager.dart';
import 'package:flutter/material.dart';
import '../../app_colors.dart';

abstract class AppTextStyles {
  static final light = TextTheme(
    displayLarge: getBoldStyle(
      color: AppColors.black,
      fontSize: FontSize.s40,
      fontFamily: AppFonts.interFamily,
    ),
    displayMedium: getSemiBoldStyle(
      color: AppColors.black,
      fontSize: FontSize.s35,
      fontFamily: AppFonts.interFamily,
    ),
    displaySmall: getMediumStyle(
      color: AppColors.black,
      fontSize: FontSize.s30,
      fontFamily: AppFonts.interFamily,
    ),

    headlineLarge: getSemiBoldStyle(
      color: AppColors.black,
      fontSize: FontSize.s24,
      fontFamily: AppFonts.interFamily,
    ),
    headlineMedium: getMediumStyle(
      color: AppColors.black,
      fontSize: FontSize.s22,
      fontFamily: AppFonts.interFamily,
    ),
    headlineSmall: getRegularStyle(
      color: AppColors.black,
      fontSize: FontSize.s18,
      fontFamily: AppFonts.interFamily,
    ),

    titleLarge: getSemiBoldStyle(
      color: AppColors.black,
      fontSize: FontSize.s22,
      fontFamily: AppFonts.interFamily,
    ),
    titleMedium: getMediumStyle(
      color: AppColors.black,
      fontSize: FontSize.s16,
      fontFamily: AppFonts.interFamily,
    ),
    titleSmall: getRegularStyle(
      color: AppColors.black,
      fontSize: FontSize.s14,
      fontFamily: AppFonts.interFamily,
    ),

    bodyLarge: getRegularStyle(
      color: AppColors.grey,
      fontSize: FontSize.s16,
      fontFamily: AppFonts.interFamily,
    ),
    bodyMedium: getRegularStyle(
      color: AppColors.grey,
      fontSize: FontSize.s14,
      fontFamily: AppFonts.interFamily,
    ),
    bodySmall: getRegularStyle(
      color: AppColors.grey,
      fontSize: FontSize.s12,
      fontFamily: AppFonts.interFamily,
    ),

    labelLarge: getMediumStyle(
      color: AppColors.placeholder,
      fontSize: FontSize.s14,
      fontFamily: AppFonts.interFamily,
    ),
    labelMedium: getMediumStyle(
      color: AppColors.placeholder,
      fontSize: FontSize.s12,
      fontFamily: AppFonts.interFamily,
    ),
    labelSmall: getRegularStyle(
      color: AppColors.placeholder,
      fontSize: FontSize.s10,
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
