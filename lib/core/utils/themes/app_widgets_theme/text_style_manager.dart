import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:flutter/widgets.dart';

TextStyle getRegularStyle({
  required Color color,
  required String fontFamily,
  double fontSize = FontSize.s12,
}) => TextStyle(
  fontFamily: fontFamily,
  fontSize: FontSize.s12,
  color: color,
  fontWeight: FontWeightManager.regular,
);

TextStyle getMediumStyle({
  required Color color,
  double fontSize = FontSize.s12,
  required String fontFamily,
}) => TextStyle(
  color: color,
  fontSize: fontSize,
  fontFamily: fontFamily,
  fontWeight: FontWeight.w500,
);

TextStyle getSemiBoldStyle({
  required Color color,
  double fontSize = FontSize.s12,
  required String fontFamily,
}) => TextStyle(
  color: color,
  fontSize: fontSize,
  fontFamily: fontFamily,
  fontWeight: FontWeight.w600,
);

TextStyle getBoldStyle({
  required Color color,
  double fontSize = FontSize.s12,
  required String fontFamily,
}) => TextStyle(
  color: color,
  fontSize: fontSize,
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
);
