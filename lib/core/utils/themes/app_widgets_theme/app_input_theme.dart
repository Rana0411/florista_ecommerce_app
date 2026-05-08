import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:flutter/material.dart';

abstract class AppInputTheme {
  static final light = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.transparent,
    hintStyle: TextStyle(
      color: AppColors.lightGrey,
      fontSize: 16,
      fontFamily: AppFonts.interFamily,
    ),
    labelStyle: TextStyle(
      color: AppColors.grey,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontFamily: AppFonts.interFamily,
    ),
    floatingLabelStyle: TextStyle(
      color: AppColors.grey,
      fontSize: 18,
      fontFamily: AppFonts.interFamily,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    errorStyle: TextStyle(
      color: AppColors.error,
      fontSize: 12,
      fontFamily: AppFonts.interFamily,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: AppColors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: AppColors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: AppColors.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: AppColors.error, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: AppColors.error, width: 2),
    ),

    contentPadding: EdgeInsets.all(16),
  );
  static final dark = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.transparent,
    hintStyle: TextStyle(
      color: AppColors.lightGrey,
      fontSize: 16,
      fontFamily: AppFonts.interFamily,
    ),
    labelStyle: TextStyle(
      color: AppColors.white,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontFamily: AppFonts.interFamily,
    ),
    floatingLabelStyle: TextStyle(
      color: AppColors.white,
      fontSize: 18,
      fontFamily: AppFonts.interFamily,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    errorStyle: TextStyle(
      color: AppColors.error,
      fontSize: 12,
      fontFamily: AppFonts.interFamily,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: AppColors.white),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: AppColors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: AppColors.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: AppColors.error, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: AppColors.error, width: 2),
    ),

    contentPadding: EdgeInsets.all(16),
  );
}
