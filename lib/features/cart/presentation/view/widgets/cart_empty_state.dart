import 'package:florista_ecommerce_app/core/router/route_path.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/assets_manager.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CartEmptyState extends StatelessWidget {
  const CartEmptyState({super.key, this.errorMessage, this.onRetry});

  final String? errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions to scale illustrations safely
    final screenSize = MediaQuery.of(context).size;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // FIX: Replaced Expanded with a responsive constraint box
            // Ensures the SVG scales nicely without breaking the ScrollView
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight:
                    screenSize.height * 0.5, // Safe 30% of screen height max
                maxWidth: 300,
              ),
              child: SvgPicture.asset(
                AssetsManager.emptyCartIllustration,
                fit: BoxFit.contain,
                semanticsLabel: 'Empty shopping cart illustration',
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Your cart is empty',
              style: TextStyle(
                fontWeight: FontWeightManager.bold,
                fontSize: FontSize.s20,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Fresh blooms are waiting for you.\nLet’s add some color to your day!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: FontSize.s14,
                color: AppColors.grey,
                height: 1.4,
              ),
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.lightPink,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: FontSize.s12,
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 28),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: SizedBox(
                width: double.infinity,
                // Cleaned up padding strategy driving adaptive text layout safely
                child: ElevatedButton(
                  onPressed: () => context.go(RoutePath.home),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Start shopping',
                    style: TextStyle(
                      fontWeight: FontWeightManager.bold,
                      fontSize: FontSize.s16,
                    ),
                  ),
                ),
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 12),
              TextButton(
                onPressed: onRetry,
                child: Text(
                  'Refresh cart',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
