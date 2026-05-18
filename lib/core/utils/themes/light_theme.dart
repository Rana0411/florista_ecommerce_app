import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/core/utils/themes/app_widgets_theme/app_button_theme.dart';
import 'package:florista_ecommerce_app/core/utils/themes/app_widgets_theme/app_input_theme.dart';
import 'package:florista_ecommerce_app/core/utils/themes/app_widgets_theme/app_text_styles.dart';
import 'package:flutter/material.dart';

abstract class TLightTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: AppTextStyles.light,
    elevatedButtonTheme: AppButtonTheme.light,
    inputDecorationTheme: AppInputTheme.light,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.primary, // progress color
      linearTrackColor: AppColors.grey, // background track
      borderRadius: BorderRadius.circular(8),
      // rounded edges
    ),

    // Inside your Theme data class
    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.primary, // The pink color from your design
      unselectedLabelColor: AppColors.grey,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: FontSize.s16,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: FontSize.s16,
      ),
      // Customizing the indicator weight and decoration
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 3.0, color: AppColors.grey),
      ),
    ),
  );
}
