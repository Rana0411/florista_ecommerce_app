import 'package:flutter/material.dart';

class ScreenSize {
  static double w(BuildContext context, double percent) {
    return MediaQuery.of(context).size.width * percent;
  }

  static double h(BuildContext context, double percent) {
    return MediaQuery.of(context).size.height * percent;
  }
}
