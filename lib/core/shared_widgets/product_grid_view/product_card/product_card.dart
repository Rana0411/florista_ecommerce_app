import 'package:florista_ecommerce_app/config/shared_models/entities/product_entity.dart';
import 'package:florista_ecommerce_app/core/app_constants.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
part 'product_image.dart';
part 'product_price_section.dart';

class ProductCard extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final ProductEntity productEntity;

  const ProductCard({
    super.key,
    this.onTap,
    this.onAddToCart,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.lightGrey, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ProductImage(imageUrl: productEntity.imageCover),
              ),
            ),

            const SizedBox(height: 10),

            /// Product Name
            Text(
              productEntity.name ?? 'No Name',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize:
                    FontSize.s14, // Lowered slightly to fit 2 lines safely
                fontWeight: FontWeightManager.medium,
              ),
            ),

            const SizedBox(height: 4),

            /// Price Section (Passes the logic down)
            PriceSection(product: productEntity),

            // Replaced Spacer() with a flexible or constant padding to avoid forcing huge card heights
            const SizedBox(height: 12),

            /// Add To Cart Button
            SizedBox(
              width: double.infinity,
              height: 36, // Increased slightly for better touch targets
              child: ElevatedButton.icon(
                onPressed: onAddToCart,
                icon: const Icon(Icons.shopping_cart_outlined, size: 16),
                label: Text(
                  S.current.addToCart,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.s10,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets
                      .zero, // Prevents text clipping on small screens
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
