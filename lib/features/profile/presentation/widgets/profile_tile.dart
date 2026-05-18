import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    this.icon,
    required this.title,
    this.isLogout = false,
    required this.onTap,
  });
  final IconData? icon;
  final String title;
  final bool isLogout;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          children: [
            if (icon != null) Icon(icon, size: 20, color: AppColors.black),
            Text(
              title,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 13,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            Spacer(),
            Icon(
              isLogout ? Icons.logout : Icons.arrow_forward_ios,
              size: 24,
              color: AppColors.lightGrey,
            ),
          ],
        ),
      ),
    );
  }
}
