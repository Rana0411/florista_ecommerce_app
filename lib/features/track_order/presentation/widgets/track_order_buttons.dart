import 'package:flutter/material.dart';

import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';

/// Full-width filled button used on the Track Order screen
/// (e.g. "Show map", "Order Delivered").
class TrackOrderPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const TrackOrderPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        // backgroundColor matches TLightTheme.elevatedButtonTheme's default,
        // so only the shape/padding/foregroundColor need overriding here.
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: Text(label, style: _labelStyle),
      ),
    );
  }
}

/// Full-width outlined button used alongside [TrackOrderPrimaryButton]
/// when two actions are shown side by side.
class TrackOrderSecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const TrackOrderSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Text(label, style: _labelStyle),
      ),
    );
  }
}

TextStyle get _labelStyle => TextStyle(
      fontFamily: AppFonts.interFamily,
      fontSize: FontSize.s14,
      fontWeight: FontWeightManager.semiBold,
    );
