import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/core/utils/responsive/screen_size.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';

/// Displays the "Estimated arrival" label with the date/time value,
/// followed by a thin divider, matching the Track Order design.
///
/// Text styles come from the app's [Theme] (`AppTextStyles.light`, wired in
/// `core/utils/themes/light_theme.dart`) instead of being built inline, so
/// the screen stays consistent with the rest of the app's typography.
class TrackOrderEtaSection extends StatelessWidget {
  final String estimatedArrival;

  const TrackOrderEtaSection({super.key, required this.estimatedArrival});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize.w(context, 0.05)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).estimatedArrival,
            style: textTheme.bodyMedium?.copyWith(color: AppColors.hintColor),
          ),
          SizedBox(height: ScreenSize.h(context, 0.008)),
          Text(
            estimatedArrival,
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeightManager.bold,
              fontSize: FontSize.s18,
            ),
          ),
          SizedBox(height: ScreenSize.h(context, 0.02)),
          Divider(color: AppColors.hintColor.withOpacity(0.25), height: 1),
        ],
      ),
    );
  }
}
