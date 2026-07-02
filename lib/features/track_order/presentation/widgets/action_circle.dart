import 'package:flutter/material.dart';

import 'package:florista_ecommerce_app/core/utils/app_colors.dart';

/// A small circular tappable icon button, used for the call / WhatsApp
/// contact actions on the driver info card.
class ActionCircle extends StatelessWidget {
  final String assetPath;
  final IconData fallbackIcon;
  final VoidCallback onTap;

  const ActionCircle({
    super.key,
    required this.assetPath,
    required this.fallbackIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.lightPink,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(9),
        child: Image.asset(
          assetPath,
          errorBuilder: (_, __, ___) =>
              Icon(fallbackIcon, color: AppColors.primary, size: 18),
        ),
      ),
    );
  }
}
