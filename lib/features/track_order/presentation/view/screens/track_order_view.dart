import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/core/utils/maps_launcher.dart';
import 'package:florista_ecommerce_app/features/orders/domain/use_cases/orders_use_cases.dart';

import 'package:florista_ecommerce_app/features/track_order/presentation/cubit/track_order_cubit.dart';
import 'package:florista_ecommerce_app/features/track_order/presentation/cubit/track_order_state.dart';
import 'package:florista_ecommerce_app/features/track_order/presentation/utils/track_date_formatter.dart';
import 'package:florista_ecommerce_app/features/track_order/presentation/widgets/animated_delivery_car.dart';
import 'package:florista_ecommerce_app/features/track_order/presentation/widgets/driver_info_card.dart';
import 'package:florista_ecommerce_app/features/track_order/presentation/widgets/track_order_buttons.dart';
import 'package:florista_ecommerce_app/features/track_order/presentation/widgets/track_order_timeline.dart';

class TrackOrderView extends StatelessWidget {
  final String? orderId;

  const TrackOrderView({super.key, this.orderId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TrackOrderCubit(getIt<GetUserOrdersUseCase>())
        ..load(orderId ?? ''),
      child: const _TrackOrderBody(),
    );
  }
}

class _TrackOrderBody extends StatelessWidget {
  const _TrackOrderBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: BlocBuilder<TrackOrderCubit, TrackOrderState>(
        builder: (context, state) {
          if (state.isLoading && state.order == null) {
            return _buildLoading();
          }
          if (state.errorMessage != null && state.order == null) {
            return _buildError(state.errorMessage!);
          }
          return _buildContent(context, state);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded,
            color: AppColors.black, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Track order',
        style: TextStyle(
          fontFamily: AppFonts.interFamily,
          fontSize: FontSize.s18,
          fontWeight: FontWeightManager.bold,
          color: AppColors.black,
        ),
      ),
    );
  }

  Widget _buildLoading() {
    // Color comes from TLightTheme.progressIndicatorTheme.
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: AppColors.error, size: 48),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.grey,
                fontFamily: AppFonts.interFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, TrackOrderState state) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(child: _buildDetails(state)),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: _buildActions(context, state),
          ),
        ],
      ),
    );
  }

  Widget _buildDetails(TrackOrderState state) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      children: [
        Text(
          'Estimated arrival',
          style: TextStyle(
            fontFamily: AppFonts.interFamily,
            fontSize: FontSize.s12,
            color: AppColors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          state.estimatedArrival != null
              ? formatTrackDate(state.estimatedArrival!)
              : '--',
          style: TextStyle(
            fontFamily: AppFonts.interFamily,
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.bold,
            color: AppColors.black,
          ),
        ),
        const Divider(height: 28),
        DriverInfoCard(driver: state.driver),
        const SizedBox(height: 16),
        const AnimatedDeliveryCar(),
        const SizedBox(height: 16),
        TrackOrderTimeline(entries: state.timeline),
      ],
    );
  }

  Widget _buildActions(BuildContext context, TrackOrderState state) {
    if (!state.isDelivered) {
      return TrackOrderPrimaryButton(
        label: 'Show map',
        onPressed: MapsLauncher.openDeliveryAddress,
      );
    }
    return Row(
      children: [
        Expanded(
          child: TrackOrderSecondaryButton(
            label: 'Show map',
            onPressed: MapsLauncher.openDeliveryAddress,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TrackOrderPrimaryButton(
            label: 'Order Delivered',
            onPressed: () => _confirmDelivery(context),
          ),
        ),
      ],
    );
  }

  void _confirmDelivery(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            const Text('Thanks for confirming! Enjoy your flowers 🌸'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }
}
