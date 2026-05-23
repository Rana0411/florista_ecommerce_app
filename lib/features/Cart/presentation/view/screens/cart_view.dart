import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/core/router/nav_helper.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/custom_buttom_navigation_bar.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/cart/domain/models/cart_item_entity.dart';
import 'package:florista_ecommerce_app/features/cart/presentation/view/utils/cart_helpers.dart';
import 'package:florista_ecommerce_app/features/cart/presentation/view/widgets/cart_animated_items_list.dart';
import 'package:florista_ecommerce_app/features/cart/presentation/view/widgets/cart_delivery_address_row.dart';
import 'package:florista_ecommerce_app/features/cart/presentation/view/widgets/cart_empty_state.dart';
import 'package:florista_ecommerce_app/features/cart/presentation/view/widgets/cart_header.dart';
import 'package:florista_ecommerce_app/features/cart/presentation/view/widgets/cart_summary_section.dart';
import 'package:florista_ecommerce_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CartCubit>()..getCart(),
      child: const _CartViewBody(),
    );
  }
}

class _CartViewBody extends StatelessWidget {
  const _CartViewBody();

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CartHeader(),
            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state.cartState.isLoading == true &&
                      state.cartState.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.isEmpty) {
                    return CartEmptyState(
                      errorMessage: state.cartState.errorMessage,
                      onRetry: () => context.read<CartCubit>().getCart(),
                    );
                  }

                  final cartData = state.cartState.data!;
                  final items = cartData.cart.cartItems;
                  final subtotal = CartHelpers.itemsSubtotal(items);
                  final deliveryFee = CartConstants.deliveryFee;
                  final total = subtotal + deliveryFee;
                  final isGlobalLoading = state.cartState.isLoading == true;

                  return Column(
                    children: [
                      Expanded(
                        child: CartAnimatedItemsList(
                          key: ValueKey(cartData.cart.id),
                          items: items,
                          busyProductId: state.busyRowId,
                          isGlobalLoading: isGlobalLoading,
                          onDelete: (item) => _onDelete(context, item),
                          onIncrement: (item) =>
                              context.read<CartCubit>().incrementItem(item),
                          onDecrement: (item) =>
                              context.read<CartCubit>().decrementItem(item),
                        ),
                      ),
                      CartSummarySection(
                        subtotal: subtotal,
                        deliveryFee: deliveryFee,
                        total: total,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        child: SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: isGlobalLoading
                                ? null
                                : () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Checkout coming soon'),
                                      ),
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Checkout',
                              style: TextStyle(
                                fontWeight: FontWeightManager.bold,
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: NavHelper.getCurrentIndex(location),
        onTap: (index) => NavHelper.onItemTapped(context, index),
      ),
    );
  }

  void _onDelete(BuildContext context, CartItemEntity item) {
    context.read<CartCubit>().removeProductFromCart(item.product.productId);
  }
}
