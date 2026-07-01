import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/track_order/domain/entities/track_order_entities.dart';
import 'package:florista_ecommerce_app/features/track_order/presentation/widgets/action_circle.dart';

class DriverInfoCard extends StatelessWidget {
  final DriverEntity driver;

  const DriverInfoCard({super.key, required this.driver});

  bool get _hasPhone => driver.phoneNumber.isNotEmpty;

  Future<void> _call() async {
    final uri = Uri(scheme: 'tel', path: driver.phoneNumber);
    await launchUrl(uri);
  }

  Future<void> _whatsapp() async {
    final phone = driver.phoneNumber.replaceAll('+', '').replaceAll(' ', '');
    final uri = Uri.parse('https://wa.me/$phone');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(
            driver.avatarAsset,
            width: 44,
            height: 44,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.lightPink,
              child: Icon(Icons.person, color: AppColors.primary),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Name + subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                driver.name,
                style: TextStyle(
                  fontFamily: AppFonts.interFamily,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.semiBold,
                  color: AppColors.black,
                ),
              ),
              Text(
                _hasPhone
                    ? 'Is your delivery hero for today'
                    : 'Driver will be assigned shortly',
                style: TextStyle(
                  fontFamily: AppFonts.interFamily,
                  fontSize: FontSize.s12,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),

        // Contact buttons — only shown once a real phone number is available
        if (_hasPhone) ...[
          ActionCircle(
            assetPath: 'assets/images/Vector.png',
            fallbackIcon: Icons.call,
            onTap: _call,
          ),
          const SizedBox(width: 8),
          ActionCircle(
            assetPath: 'assets/images/whatsapp.png',
            fallbackIcon: Icons.chat_bubble,
            onTap: _whatsapp,
          ),
        ],
      ],
    );
  }
}
