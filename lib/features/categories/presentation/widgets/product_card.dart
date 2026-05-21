import 'package:flutter/material.dart';

import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/features/categories/domain/entities/product_entity.dart';

import '../../../../generated/l10n.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.hintColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Product image ──────────────────────────────────────────────
          Expanded(
            child: ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(16)),
              child: Container(
                width: double.infinity,
                color: AppColors.white,
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Center(
                    child: Icon(
                      Icons.local_florist,
                      size: 48,
                      color: AppColors.primary,
                    ),
                  ),
                  loadingBuilder: (_, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ),

          // ── Info section ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  product.name,
                  style: textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                // Price row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'EGP ${product.price.toStringAsFixed(0)}',
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                    if (product.hasDiscount) ...[
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          product.originalPrice.toStringAsFixed(0),
                          style: textTheme.labelSmall?.copyWith(
                            decoration: TextDecoration.lineThrough,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${product.discountPercent.toStringAsFixed(0)}%',
                        style: textTheme.labelSmall?.copyWith(
                          color: AppColors.lightGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  height: 34,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      textStyle: textTheme.labelMedium,
                    ),
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 14,
                    ),
                    label: Text("Add to cart"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}