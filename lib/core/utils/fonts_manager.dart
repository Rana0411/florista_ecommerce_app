import 'package:flutter/material.dart';

class AppFonts {
  static final interFamily = "Inter";
  static final imfEllEnglish = "IMFellEnglish";
}

abstract class FontWeightManager {
  static const FontWeight light = FontWeight.w300; // Maps to 18pt-Light
  static const FontWeight regular = FontWeight.w400; // Maps to 18pt-Regular
  static const FontWeight medium = FontWeight.w500; // Maps to 18pt-Medium
  static const FontWeight semiBold = FontWeight.w600; // Maps to 18pt-SemiBold
  static const FontWeight bold = FontWeight.w700; // Maps to 18pt-Bold
}

abstract class FontSize {
  static const double s10 = 10;
  static const double s12 = 12;
  static const double s14 = 14;
  static const double s16 = 16;
  static const double s17 = 17;
  static const double s18 = 18;
  static const double s20 = 20;
  static const double s22 = 22;
  static const double s24 = 24;
  static const double s25 = 25;
  static const double s28 = 28;
  static const double s30 = 30;
  static const double s35 = 35;
  static const double s40 = 40;
  static const double s48 = 48;
}
