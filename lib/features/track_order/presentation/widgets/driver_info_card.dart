import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/track_order/domain/entities/track_order_entities.dart';
import 'package:florista_ecommerce_app/features/track_order/presentation/widgets/action_circle.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';

class DriverInfoCard extends StatelessWidget {
  final DriverEntity driver;

  const DriverInfoCard({super.key, required this.driver});

  bool get _hasPhone => driver.phoneNumber.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _DriverAvatar(avatarAsset: driver.avatarAsset),
        const SizedBox(width: 12),
        Expanded(
          child: _DriverInfo(name: driver.name, hasPhone: _hasPhone),
        ),
        if (_hasPhone)
          _DriverContactActions(phoneNumber: driver.phoneNumber),
      ],
    );
  }
}

/// Const, standalone widget so it isn't rebuilt whenever [DriverInfoCard]'s
/// parent (the tracking BlocBuilder) rebuilds for unrelated state changes.
class _DriverAvatar extends StatelessWidget {
  final String avatarAsset;

  const _DriverAvatar({required this.avatarAsset});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.asset(
        avatarAsset,
        width: 44,
        height: 44,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.lightPink,
          child: Icon(Icons.person, color: AppColors.primary),
        ),
      ),
    );
  }
}

class _DriverInfo extends StatelessWidget {
  final String name;
  final bool hasPhone;

  const _DriverInfo({required this.name, required this.hasPhone});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontFamily: AppFonts.interFamily,
            fontSize: FontSize.s16,
            fontWeight: FontWeightManager.semiBold,
            color: AppColors.black,
          ),
        ),
        Text(
          hasPhone
              ? S.of(context).isYourDeliveryHeroForToday
              : S.of(context).driverWillBeAssignedShortly,
          style: TextStyle(
            fontFamily: AppFonts.interFamily,
            fontSize: FontSize.s12,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}

/// Only shown once a real phone number is available. Const constructor —
/// the call/WhatsApp handlers are static functions taking [phoneNumber]
/// directly instead of instance methods, so this widget needs no mutable
/// state and never has to rebuild for anything other than a phone number
/// change.
class _DriverContactActions extends StatelessWidget {
  final String phoneNumber;

  const _DriverContactActions({required this.phoneNumber});

  static Future<void> _call(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(uri);
  }

  static Future<void> _whatsapp(String phoneNumber) async {
    final phone = phoneNumber.replaceAll('+', '').replaceAll(' ', '');
    final uri = Uri.parse('https://wa.me/$phone');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ActionCircle(
          assetPath: 'assets/images/Vector.png',
          fallbackIcon: Icons.call,
          onTap: () => _call(phoneNumber),
        ),
        const SizedBox(width: 8),
        ActionCircle(
          assetPath: 'assets/images/whatsapp.png',
          fallbackIcon: Icons.chat_bubble,
          onTap: () => _whatsapp(phoneNumber),
        ),
      ],
    );
  }
}
