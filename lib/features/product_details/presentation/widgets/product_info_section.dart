import 'package:flutter/material.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/features/categories/domain/entities/product_entity.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';

class ProductInfoSection extends StatelessWidget {
  final ProductEntity product;

  const ProductInfoSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'EGP ${product.price.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: product.quantity > 0
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  product.quantity > 0
                      ? S.of(context).inStock
                      : S.of(context).outOfStock,
                  style: TextStyle(
                    color: product.quantity > 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Text(
            product.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 20),

          Text(
            S.of(context).description,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            product.description,
            style: const TextStyle(fontSize: 16, height: 1.6),
          ),

          const SizedBox(height: 24),

          Text(
            S.of(context).bouquetInclude,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            "• Pink roses: 15\n• White wrap",
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 16),
          Center(
            child: Text(
              S.of(context).allPricesIncludeTax,
              style: TextStyle(color: AppColors.hintColor, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
