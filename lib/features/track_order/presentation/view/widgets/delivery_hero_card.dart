import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/core/utils/responsive/screen_size.dart';
import 'package:flutter/material.dart';

/// Shows the delivery person's avatar, name, a short subtitle and quick
/// "call" / "whatsapp" action buttons.
///
/// Uses [AppColors] for every color and the app's [Theme] textTheme
/// (`AppTextStyles.light`) for typography, so it stays visually consistent
/// with the rest of the app.
class DeliveryHeroCard extends StatelessWidget {
  final String driverName;
  final String subtitle;
  final VoidCallback? onCallTap;
  final VoidCallback? onWhatsAppTap;

  const DeliveryHeroCard({
    super.key,
    required this.driverName,
    required this.subtitle,
    this.onCallTap,
    this.onWhatsAppTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize.w(context, 0.05)),
      child: Row(
        children: [
          const _DriverAvatar(),
          SizedBox(width: ScreenSize.w(context, 0.03)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  driverName,
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                ),
                SizedBox(height: ScreenSize.h(context, 0.003)),
                Text(
                  subtitle,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.hintColor,
                  ),
                ),
              ],
            ),
          ),
          _ActionIconButton(icon: Icons.call_rounded, onTap: onCallTap),
          SizedBox(width: ScreenSize.w(context, 0.025)),
          _ActionIconButton(
            icon: Icons.chat_bubble_rounded,
            onTap: onWhatsAppTap,
          ),
        ],
      ),
    );
  }
}

class _DriverAvatar extends StatelessWidget {
  const _DriverAvatar();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: AppColors.lightPink,
      child: Icon(Icons.person_rounded, color: AppColors.primary, size: 26),
    );
  }
}

class _ActionIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _ActionIconButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 38,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.lightPink,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.primary, size: 18),
      ),
    );
  }
}
