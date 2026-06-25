// import 'package:florista_ecommerce_app/config/di/di.dart';
// import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
// import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
// import 'package:florista_ecommerce_app/core/utils/responsive/screen_size.dart';
// import 'package:florista_ecommerce_app/features/orders/data/order_model.dart';
// import 'package:florista_ecommerce_app/features/orders/data/order_repository.dart';
// import 'package:florista_ecommerce_app/features/track_order/domain/models/order_status_step.dart';
// import 'package:florista_ecommerce_app/features/track_order/presentation/view/widgets/delivery_hero_card.dart';
// import 'package:florista_ecommerce_app/features/track_order/presentation/view/widgets/delivery_vehicle_card.dart';
// import 'package:florista_ecommerce_app/features/track_order/presentation/view/widgets/order_status_timeline.dart';
// import 'package:florista_ecommerce_app/features/track_order/presentation/view/widgets/track_order_app_bar.dart';
// import 'package:florista_ecommerce_app/features/track_order/presentation/view/widgets/track_order_eta_section.dart';
// import 'package:florista_ecommerce_app/generated/l10n.dart';
// import 'package:flutter/material.dart';
//
// /// "Track order" screen.
// ///
// /// If [orderId] is provided, this screen subscribes to that order's live
// /// Firestore document (updated by the Tracking app / driver) and renders
// /// real status + ETA + driver info. Without an [orderId] it falls back to
// /// static demo data, so the screen still renders standalone in dev/design.
// class TrackOrderView extends StatelessWidget {
//   final String? orderId;
//   final String estimatedArrival;
//   final String driverName;
//   final List<OrderStatusStep>? steps;
//
//   const TrackOrderView({
//     super.key,
//     this.orderId,
//     this.estimatedArrival = '03 Sep 2024, 11:00 AM',
//     this.driverName = 'Muhamed',
//     this.steps,
//   });
//
//   List<OrderStatusStep> _defaultSteps(BuildContext context) {
//     final s = S.of(context);
//     return [
//       OrderStatusStep(
//         title: s.receivedYourOrder,
//         dateTime: '03 Sep 2024 - 2:10',
//         isCompleted: true,
//       ),
//       OrderStatusStep(
//         title: s.preparingYourOrder,
//         dateTime: '03 Sep 2024 - 2:10',
//       ),
//       OrderStatusStep(
//         title: s.outForDelivery,
//         dateTime: '03 Sep 2024 - 2:10',
//       ),
//       OrderStatusStep(title: s.delivered, dateTime: '03 Sep 2024 - 2:10'),
//     ];
//   }
//
//   /// Maps the order's `status` string (set by the Tracking app) into the
//   /// timeline steps used by [OrderStatusTimeline].
//   List<OrderStatusStep> _stepsFromOrder(BuildContext context, OrderModel order) {
//     final s = S.of(context);
//     const order_ = [
//       OrderStatusValues.pending,
//       OrderStatusValues.preparing,
//       OrderStatusValues.outForDelivery,
//       OrderStatusValues.delivered,
//     ];
//     final currentIndex = order_.indexOf(order.status);
//     final dateLabel = (order.updatedAt ?? order.createdAt)?.toString() ?? '';
//
//     return [
//       OrderStatusStep(
//         title: s.receivedYourOrder,
//         dateTime: dateLabel,
//         isCompleted: currentIndex >= 0,
//       ),
//       OrderStatusStep(
//         title: s.preparingYourOrder,
//         dateTime: dateLabel,
//         isCompleted: currentIndex >= 1,
//       ),
//       OrderStatusStep(
//         title: s.outForDelivery,
//         dateTime: dateLabel,
//         isCompleted: currentIndex >= 2,
//       ),
//       OrderStatusStep(
//         title: s.delivered,
//         dateTime: dateLabel,
//         isCompleted: currentIndex >= 3,
//       ),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     if (orderId == null) {
//       return _buildScaffold(
//         context,
//         eta: estimatedArrival,
//         driver: driverName,
//         timelineSteps: steps ?? _defaultSteps(context),
//       );
//     }
//
//     return StreamBuilder<OrderModel>(
//       stream: getIt<OrderRepository>().streamOrder(orderId!),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             backgroundColor: AppColors.white,
//             appBar: TrackOrderAppBar(title: s.trackOrder),
//             body: const Center(child: CircularProgressIndicator()),
//           );
//         }
//         if (snapshot.hasError || !snapshot.hasData) {
//           return Scaffold(
//             backgroundColor: AppColors.white,
//             appBar: TrackOrderAppBar(title: s.trackOrder),
//             body: Center(child: Text('${snapshot.error ?? "Order not found"}')),
//           );
//         }
//
//         final order = snapshot.data!;
//         return _buildScaffold(
//           context,
//           eta: order.eta ?? estimatedArrival,
//           driver: order.driverName ?? driverName,
//           timelineSteps: _stepsFromOrder(context, order),
//         );
//       },
//     );
//   }
//
//   Widget _buildScaffold(
//     BuildContext context, {
//     required String eta,
//     required String driver,
//     required List<OrderStatusStep> timelineSteps,
//   }) {
//     final s = S.of(context);
//     final textTheme = Theme.of(context).textTheme;
//
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: TrackOrderAppBar(title: s.trackOrder),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: ScreenSize.h(context, 0.01)),
//                     TrackOrderEtaSection(estimatedArrival: eta),
//                     SizedBox(height: ScreenSize.h(context, 0.02)),
//                     DeliveryHeroCard(
//                       driverName: driver,
//                       subtitle: s.isYourDeliveryHeroForToday,
//                       onCallTap: () {},
//                       onWhatsAppTap: () {},
//                     ),
//                     const DeliveryVehicleCard(),
//                     SizedBox(height: ScreenSize.h(context, 0.01)),
//                     OrderStatusTimeline(steps: timelineSteps),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(
//                 ScreenSize.w(context, 0.05),
//                 0,
//                 ScreenSize.w(context, 0.05),
//                 ScreenSize.h(context, 0.025),
//               ),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: ScreenSize.h(context, 0.065),
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   child: Text(
//                     s.showMap,
//                     style: textTheme.titleMedium?.copyWith(
//                       color: AppColors.white,
//                       fontWeight: FontWeightManager.semiBold,
//                       fontSize: FontSize.s16,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
