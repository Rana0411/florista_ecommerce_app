import 'package:florista_ecommerce_app/core/router/route_path.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/features/order_success/presentation/view_model/order_success_view_model.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/order_success_icon.dart';

class OrderSuccessView extends StatefulWidget {
  const OrderSuccessView({super.key, this.orderId});

  final String? orderId;

  @override
  State<OrderSuccessView> createState() => _OrderSuccessViewState();
}

class _OrderSuccessViewState extends State<OrderSuccessView> {
  static const double _horizontalPadding = 24;
  static const double _topSpacing = 24;
  static const double _titleSpacing = 48;
  static const double _buttonSpacing = 36;

  @override
  void initState() {
    super.initState();
    context.read<OrderSuccessViewModel>().getOrderSuccessDetails(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.black),
        ),
        title: Text(
          l10n.trackOrder,
          style: theme.textTheme.titleMedium?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
          child: Column(
            children: [
              const SizedBox(height: _topSpacing),
              const OrderSuccessIcon(),
              const SizedBox(height: _titleSpacing),
              Text(
                l10n.orderPlacedSuccessfully,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: _buttonSpacing),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push(RoutePath.myOrders),
                  child: Text(l10n.trackOrder),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}