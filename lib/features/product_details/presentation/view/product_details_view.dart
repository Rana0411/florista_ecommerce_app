import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/add_to_cart_elevated_button.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_requests_model.dart';
import 'package:florista_ecommerce_app/features/product_details/presentation/cubit/product_details_state.dart';
import 'package:florista_ecommerce_app/features/product_details/presentation/widgets/product_image_carousel.dart';
import 'package:florista_ecommerce_app/features/product_details/presentation/widgets/product_info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:florista_ecommerce_app/features/categories/domain/entities/product_entity.dart';
import 'package:florista_ecommerce_app/features/product_details/presentation/cubit/product_details_view_model.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductEntity? product;

  const ProductDetailsView({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt<ProductDetailsCubit>();
        final id = product?.id ?? '';
        if (id.isNotEmpty) {
          cubit.getProduct(id);
        }
        return cubit;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductDetailsError && product == null) {
              return Center(child: Text(state.message));
            }

            final currentProduct = state is ProductDetailsSuccess
                ? state.product
                : product;

            if (currentProduct == null) {
              return const Center(child: Text("Product not found"));
            }

            // Use images list; fallback to single image if list is empty
            final imageList = currentProduct.images.isNotEmpty
                ? currentProduct.images
                : [currentProduct.image];

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductImageCarousel(
                        images: imageList,
                        onBack: () => Navigator.pop(context),
                      ),
                      ProductInfoSection(product: currentProduct),
                      // bottom padding so FAB doesn't cover content
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
                // Floating "Add to cart" button pinned at bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    child: AddToCartButton(
                      height: 56,
                      addProductRequest: AddProductRequest(
                        productId: product?.id ?? "",
                        quantity: 1,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
