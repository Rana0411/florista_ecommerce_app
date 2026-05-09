import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

abstract class CustomAppBarTheme {
  static final light = AppBarTheme(
    backgroundColor: AppColors.transparent,
    foregroundColor: AppColors.black,
    leadingWidth: 25,
    actionsPadding: EdgeInsets.only(right: 20),
    titleSpacing: 0,
    elevation: 0,
  );
  static final dark = AppBarTheme(
    backgroundColor: AppColors.transparent,
    foregroundColor: AppColors.white,
    leadingWidth: 25,
    actionsPadding: EdgeInsets.only(right: 20),
    titleSpacing: 0,
    elevation: 0,
  );
}
