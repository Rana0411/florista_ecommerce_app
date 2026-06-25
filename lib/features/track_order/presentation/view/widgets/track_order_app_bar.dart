import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:flutter/material.dart';

/// App bar for the Track Order screen.
///
/// Kept local to this feature (instead of touching the shared
/// `core/shared_widgets/custom_app_bar.dart`) so this feature's changes
/// stay self-contained. Still reuses [AppColors] and [FontWeightManager]
/// from `core/` for styling.
class TrackOrderAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackTap;

  const TrackOrderAppBar({super.key, required this.title, this.onBackTap});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.black),
        onPressed: onBackTap ?? () => Navigator.of(context).maybePop(),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeightManager.bold)),
    );
  }
}
