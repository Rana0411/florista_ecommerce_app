import 'package:florista_ecommerce_app/core/utils/responsive/screen_size.dart';
import 'package:florista_ecommerce_app/features/track_order/domain/models/order_status_step.dart';
import 'package:florista_ecommerce_app/features/track_order/presentation/view/widgets/order_status_tile.dart';
import 'package:flutter/material.dart';

/// Renders the full vertical list of [OrderStatusStep]s as a connected
/// timeline.
class OrderStatusTimeline extends StatelessWidget {
  final List<OrderStatusStep> steps;

  const OrderStatusTimeline({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize.w(context, 0.05)),
      child: Column(
        children: List.generate(steps.length, (index) {
          final step = steps[index];
          return OrderStatusTile(
            title: step.title,
            dateTime: step.dateTime,
            isActive: step.isCompleted,
            isLast: index == steps.length - 1,
          );
        }),
      ),
    );
  }
}
