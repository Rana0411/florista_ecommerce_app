import 'package:florista_ecommerce_app/core/shared_widgets/product_grid_view/products_grid_view.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/product_grid_view/shimmer_product_grid_view.dart';
import 'package:florista_ecommerce_app/features/occasions/presentation/view_model/occasion_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OccasionProductsBody extends StatelessWidget {
  const OccasionProductsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OccasionCubit, OccasionState>(
      buildWhen: (previous, current) =>
          previous.productState != current.productState,
      builder: (context, state) {
        if (state.productState.isLoading == true) {
          return const ProductsGridShimmer();
        }

        if (state.productState.errorMessage != null) {
          return Center(child: Text(state.productState.errorMessage!));
        }

        final products = state.productState.data ?? [];

        if (products.isEmpty) {
          return const Center(child: Text('No products for this occasion'));
        }

        return ProductsGridView(products: products);
      },
    );
  }
}
