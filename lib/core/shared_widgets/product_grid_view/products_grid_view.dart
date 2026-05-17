import 'package:florista_ecommerce_app/config/shared_models/entities/product_entity.dart';
import 'package:flutter/material.dart';

import 'product_card/product_card.dart';

class ProductsGridView extends StatelessWidget {
  final List<ProductEntity> products;

  const ProductsGridView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final itemWidth = (width - 48) / 2;
        final itemHeight = itemWidth * 2.25;

        int crossAxisCount;

        if (width < 600) {
          crossAxisCount = 2;
        } else if (width < 900) {
          crossAxisCount = 3;
        } else {
          crossAxisCount = 4;
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: itemWidth / itemHeight,
          ),
          itemBuilder: (_, index) {
            return ProductCard(
              productEntity: products[index],
              onTap: () {},
              onAddToCart: () {},
            );
          },
        );
      },
    );
  }
}
