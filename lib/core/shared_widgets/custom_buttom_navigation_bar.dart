import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.unSelectedIconColor,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          label: S.of(context).home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.category_outlined),
          label: S.of(context).categories,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.shopping_cart_outlined),
          label: S.of(context).cart,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          label: S.of(context).profile,
        ),
      ],
    );
  }
}
