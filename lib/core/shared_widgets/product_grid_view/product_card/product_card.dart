import 'package:florista_ecommerce_app/config/shared_models/products/product_entity.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_requests_model.dart';
import 'package:florista_ecommerce_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final VoidCallback? onTap;
  final ProductEntity productEntity;

  const ProductCard({
    super.key,
    required this.onTap,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  productEntity.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              productEntity.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeightManager.medium),
            ),

            const SizedBox(height: 4),

            Row(
              children: [
                Text(
                  '${S.current.EGB} ${productEntity.price.toInt()}',
                  style: const TextStyle(
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s16,
                  ),
                ),

                const SizedBox(width: 6),

                Text(
                  productEntity.oldPrice.toInt().toString(),
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: AppColors.grey,
                  ),
                ),

                const SizedBox(width: 6),

                Text(
                  '${productEntity.discount}%',
                  style: TextStyle(
                    color: AppColors.success,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 42,
              child: BlocBuilder<CartCubit, CartState>(
                buildWhen: (previous, current) {
                  final prevInCart =
                      (previous.cartState.data?.cart.cartItems ?? []).any(
                        (item) => item.product.id == productEntity.id,
                      );
                  final currInCart =
                      (current.cartState.data?.cart.cartItems ?? []).any(
                        (item) => item.product.id == productEntity.id,
                      );
                  return prevInCart != currInCart ||
                      previous.busyRowId != current.busyRowId;
                },
                builder: (context, state) {
                  final cartItems = state.cartState.data?.cart.cartItems ?? [];
                  final isInCart = cartItems.any(
                    (item) => item.product.id == productEntity.id,
                  );
                  final isBusy = state.busyRowId == productEntity.id;

                  return ElevatedButton.icon(
                    onPressed: () {
                      (isInCart || isBusy)
                          ? null
                          : context.read<CartCubit>().addProductToCartUseCase(
                              AddProductRequest(
                                productId: productEntity.id,
                                quantity: 1,
                              ),
                            );
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
                    label: Text(S.current.addToCart),
                    style: (isInCart || isBusy)
                        ? ElevatedButton.styleFrom(
                            backgroundColor: AppColors.lightGrey,
                            foregroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(),
                          )
                        : ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
