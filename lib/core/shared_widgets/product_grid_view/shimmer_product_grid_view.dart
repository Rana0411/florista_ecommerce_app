import 'package:florista_ecommerce_app/core/shared_widgets/product_grid_view/product_card/shimmer_product_card.dart';
import 'package:flutter/material.dart';

class ProductsGridShimmer extends StatelessWidget {
  final int itemCount;

  const ProductsGridShimmer({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) => const ProductCardShimmer(),
    );
  }
}
