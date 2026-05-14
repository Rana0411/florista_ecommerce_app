import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required PreferredSize bottom,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(Icons.arrow_back_ios, color: AppColors.black),
      elevation: 0,
      title: Text(title, style: TextStyle(fontWeight: FontWeightManager.bold)),
    );
  }
}
