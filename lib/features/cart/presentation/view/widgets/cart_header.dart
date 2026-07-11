import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/cart/presentation/view/widgets/cart_delivery_address_row.dart';
import 'package:florista_ecommerce_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartHeader extends StatelessWidget {
  const CartHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final itemCount = state.cartState.data?.numOfCartItems ?? 0;

        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      S.of(context).cartTitle(itemCount),
                      style: TextStyle(
                        fontWeight: FontWeightManager.bold,
                        fontSize: FontSize.s20,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const CartDeliveryAddressRow(),
            ],
          ),
        );
      },
    );
  }
}
