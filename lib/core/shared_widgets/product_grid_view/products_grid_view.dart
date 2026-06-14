import 'package:florista_ecommerce_app/config/shared_models/products/product_entity.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_requests_model.dart';
import 'package:florista_ecommerce_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          onAddToCart: () {
            BlocProvider.of<CartCubit>(context).addProductToCart(
              AddProductRequest(
                productId: product.id,
                quantity: product.quantity,
              ),
            );
          },
          productEntity: product,
        );
      },
    );
  }
}
