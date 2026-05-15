import 'package:florista_ecommerce_app/config/shared_models/entities/product_entity.dart';
import 'package:flutter/material.dart';

import 'product_card/product_card.dart';

class ProductsGridView extends StatelessWidget {
  final List<ProductEntity> products;

  const ProductsGridView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return ProductCard(
          onTap: () {},
          onAddToCart: () {},
          productEntity: product,
        );
      },
    );
  }
}
