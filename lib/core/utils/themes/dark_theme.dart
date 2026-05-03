import 'package:florista_ecommerce_app/core/utils/themes/app_widgets_theme/app_button_theme.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/themes/app_widgets_theme/app_input_theme.dart';
import 'package:florista_ecommerce_app/core/utils/themes/app_widgets_theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class TDarkTheme {
  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    dialogBackgroundColor: AppColors.grey,
    primaryColor: AppColors.primary,
    elevatedButtonTheme: AppButtonTheme.dark,
    textTheme: AppTextStyles.dark,
    inputDecorationTheme: AppInputTheme.dark,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.primary, // progress color
      linearTrackColor: AppColors.grey, // background track
      borderRadius: BorderRadius.circular(8), // rounded edges
    ),
  );
}
