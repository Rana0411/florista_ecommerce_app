import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/core/utils/maps_launcher.dart';
import 'package:florista_ecommerce_app/features/orders/domain/use_cases/orders_use_cases.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';

import 'package:florista_ecommerce_app/features/track_order/data/data_sources/track_order_remote_data_source.dart';
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
      // TrackOrderRemoteDataSource streams the live driver/timeline fields
      // straight from Firestore — not wired through GetIt (no @injectable
      // codegen for it yet), so it's constructed directly here.
      create: (_) => TrackOrderCubit(
        getIt<GetUserOrdersUseCase>(),
        TrackOrderRemoteDataSource(FirebaseFirestore.instance),
      )..load(orderId ?? ''),
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
      appBar: const _TrackOrderAppBar(),
      body: BlocBuilder<TrackOrderCubit, TrackOrderState>(
        builder: (context, state) {
          if (state.isLoading && state.order == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.errorMessage != null && state.order == null) {
            return _ErrorView(message: state.errorMessage!);
          }
          return _TrackOrderContent(state: state);
        },
      ),
    );
  }
}

/// App bar for the Track Order screen. Const constructor + its own class
/// (rather than a `_build` method on the screen) so it isn't rebuilt every
/// time the BlocBuilder below it rebuilds.
class _TrackOrderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _TrackOrderAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded,
            color: AppColors.black, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        S.of(context).trackOrder,
        style: TextStyle(
          fontFamily: AppFonts.interFamily,
          fontSize: FontSize.s18,
          fontWeight: FontWeightManager.bold,
          color: AppColors.black,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
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
}

class _TrackOrderContent extends StatelessWidget {
  final TrackOrderState state;

  const _TrackOrderContent({required this.state});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(child: _TrackOrderDetails(state: state)),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: _TrackOrderActions(state: state),
          ),
        ],
      ),
    );
  }
}

class _TrackOrderDetails extends StatelessWidget {
  final TrackOrderState state;

  const _TrackOrderDetails({required this.state});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      children: [
        Text(
          S.of(context).estimatedArrival,
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
}

class _TrackOrderActions extends StatelessWidget {
  final TrackOrderState state;

  const _TrackOrderActions({required this.state});

  @override
  Widget build(BuildContext context) {
    if (!state.isDelivered) {
      return TrackOrderPrimaryButton(
        label: S.of(context).showMap,
        onPressed: MapsLauncher.openDeliveryAddress,
      );
    }
    return Row(
      children: [
        Expanded(
          child: TrackOrderSecondaryButton(
            label: S.of(context).showMap,
            onPressed: MapsLauncher.openDeliveryAddress,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TrackOrderPrimaryButton(
            label: S.of(context).orderDelivered,
            onPressed: () => _confirmDelivery(context),
          ),
        ),
      ],
    );
  }

  void _confirmDelivery(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context).orderDeliveredConfirmationMessage),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }
}
