import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 36,
      child: TextField(
        decoration: InputDecoration(
          hintText: S.current.search,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 35,
            minHeight: 35,
          ),
          prefixIcon: Icon(Icons.search, size: 25, color: AppColors.lightGrey),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.lightGrey),
          ),
        ),
      ),
    );
  }
}
