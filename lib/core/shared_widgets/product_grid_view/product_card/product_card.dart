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
    required this.productEntity,
    this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.lightGrey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ProductImage(imageUrl: productEntity.imageCover),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              productEntity.name ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),

            PriceSection(product: productEntity),

            const Spacer(),

            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 42),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onAddToCart,
                  icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                  label: Text(
                    S.current.addToCart,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                    ),
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
