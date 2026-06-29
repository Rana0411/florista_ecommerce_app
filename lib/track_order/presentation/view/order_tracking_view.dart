import 'package:florista_ecommerce_app/track_order/presentation/cubit/order_tracking_cubit.dart';
import 'package:florista_ecommerce_app/track_order/presentation/widget/driver_info.dart';
import 'package:florista_ecommerce_app/track_order/presentation/widget/time_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/core/utils/maps_launcher.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/order_tracking_entity.dart';
import '../cubit/order_tracking_state.dart';

class TrackOrderView extends StatefulWidget {
  final String? orderId;
  const TrackOrderView({super.key, this.orderId});

  @override
  State<TrackOrderView> createState() => _TrackOrderViewState();
}

class _TrackOrderViewState extends State<TrackOrderView> {
  late final TrackOrderCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt.get<TrackOrderCubit>();
    if (widget.orderId != null) _cubit.loadTracking(widget.orderId!);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => context.pop()),
        title: Text(S.of(context).trackOrder, style: TextStyle(fontFamily: AppFonts.interFamily, fontWeight: FontWeight.w600, color: Colors.black)),
      ),
      body: BlocBuilder<TrackOrderCubit, TrackOrderState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state.isLoading) return const Center(child: CircularProgressIndicator());
          if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          }
          final tracking = state.tracking;
          if (tracking == null) return const Center(child: Text('No tracking information yet'));

          final isDelivered = tracking.status == OrderTrackingStatus.delivered;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (tracking.estimatedArrival != null) ...[
                  // Estimated arrival card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                    child: Row(children: [const Icon(Icons.access_time), const SizedBox(width: 12), Text(S.of(context).estimatedArrival)]),
                  ),
                  const SizedBox(height: 24),
                ],
                if (tracking.driverName != null)
                  // DriverInfoCard(
                  //   driverName: tracking.driverName!,
                  //   driverPhone: tracking.driverPhone ?? '',
                  //   onCall: () => DriverContactLauncher.callDriver(context, tracking.driverPhone ?? ''),
                  //   onText: () => DriverContactLauncher.textDriver(context, tracking.driverPhone ?? ''),
                  // ),
                const SizedBox(height: 24),
                Image.asset('assets/images/Car.png', height: 150),
                const SizedBox(height: 32),
                TrackingTimeline(tracking: tracking),
                const SizedBox(height: 40),
                if (!isDelivered)
                  OutlinedButton(onPressed: () => MapsLauncher.openDeliveryAddress(), child: Text(S.of(context).showMap))
                else
                  ElevatedButton(onPressed: () => context.pop(), child: const Text('Order Delivered')),
              ],
            ),
          );
        },
      ),
    );
  }
}