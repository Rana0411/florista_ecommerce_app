import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:flutter/material.dart';

abstract class CustomAppBarTheme {
  static final light = AppBarTheme(
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.black,
    leadingWidth: 25,
    actionsPadding: EdgeInsets.only(right: 20),
    iconTheme: IconThemeData(color: AppColors.black),
    titleSpacing: 0,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: AppColors.black,
      fontWeight: FontWeightManager.bold,
      fontSize: FontSize.s18,
    ),
  );
  static final dark = AppBarTheme(
    backgroundColor: AppColors.black,
    foregroundColor: AppColors.white,
    leadingWidth: 25,
    actionsPadding: EdgeInsets.only(right: 20),
    titleSpacing: 0,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.black),
    titleTextStyle: TextStyle(
      color: AppColors.black,
      fontWeight: FontWeightManager.bold,
      fontSize: FontSize.s18,
    ),
  );
}
