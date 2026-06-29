import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/core/utils/maps_launcher.dart';
import 'package:florista_ecommerce_app/features/orders/domain/use_cases/orders_use_cases.dart';

import 'package:florista_ecommerce_app/features/track_order/presentation/cubit/track_order_cubit.dart';
import 'package:florista_ecommerce_app/features/track_order/presentation/cubit/track_order_state.dart';
import 'package:florista_ecommerce_app/features/track_order/presentation/widgets/animated_delivery_car.dart';
import 'package:florista_ecommerce_app/features/track_order/presentation/widgets/driver_info_card.dart';
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
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
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
      ),
      body: BlocBuilder<TrackOrderCubit, TrackOrderState>(
        builder: (context, state) {
          if (state.isLoading && state.order == null) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state.errorMessage != null && state.order == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        color: AppColors.error, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      state.errorMessage!,
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

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: state.isDelivered
                      ? Row(
                          children: [
                            Expanded(
                              child: _SecondaryButton(
                                label: 'Show map',
                                onPressed: MapsLauncher.openDeliveryAddress,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _PrimaryButton(
                                label: 'Order Delivered',
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                          'Thanks for confirming! Enjoy your flowers 🌸'),
                                      backgroundColor: AppColors.primary,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        )
                      : _PrimaryButton(
                          label: 'Show map',
                          onPressed: MapsLauncher.openDeliveryAddress,
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _PrimaryButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: AppFonts.interFamily,
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.semiBold,
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _SecondaryButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: AppFonts.interFamily,
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.semiBold,
          ),
        ),
      ),
    );
  }
}
