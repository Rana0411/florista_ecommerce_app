import 'package:florista_ecommerce_app/track_order/domain/entities/order_tracking_entity.dart';
import 'package:flutter/material.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';

class TrackingTimeline extends StatelessWidget {
  final OrderTrackingEntity tracking;

  const TrackingTimeline({super.key, required this.tracking});

  @override
  Widget build(BuildContext context) {
    final steps = [
      _StepData(
        label: S.of(context).receivedYourOrder,
        time: tracking.receivedAt,
        isCompleted: tracking.status.index >= OrderTrackingStatus.receivedYourOrder.index,
      ),
      _StepData(
        label: S.of(context).preparingYourOrder,
        time: tracking.preparingAt,
        isCompleted: tracking.status.index >= OrderTrackingStatus.preparingYourOrder.index,
      ),
      _StepData(
        label: S.of(context).outForDelivery,
        time: tracking.outForDeliveryAt,
        isCompleted: tracking.status.index >= OrderTrackingStatus.outForDelivery.index,
      ),
      _StepData(
        label: S.of(context).delivered,
        time: tracking.deliveredAt,
        isCompleted: tracking.status.index >= OrderTrackingStatus.delivered.index,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).status,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.interFamily,
          ),
        ),
        const SizedBox(height: 16),
        ...steps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          final isLast = index == steps.length - 1;
          return _TimelineStep(step: step, isLast: isLast);
        }).toList(),
      ],
    );
  }
}

class _StepData {
  final String label;
  final DateTime? time;
  final bool isCompleted;

  _StepData({required this.label, required this.time, required this.isCompleted});
}

class _TimelineStep extends StatelessWidget {
  final _StepData step;
  final bool isLast;

  const _TimelineStep({super.key, required this.step, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: step.isCompleted ? AppColors.primary : Colors.grey.shade300,
                border: Border.all(
                  color: step.isCompleted ? AppColors.primary : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: step.isCompleted
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: step.isCompleted ? AppColors.primary : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.label,
                style: TextStyle(
                  fontFamily: AppFonts.interFamily,
                  fontWeight: step.isCompleted ? FontWeight.w600 : FontWeight.normal,
                  color: step.isCompleted ? Colors.black : Colors.grey,
                ),
              ),
              if (step.time != null)
                Text(
                  '${step.time!.day.toString().padLeft(2, '0')}/${step.time!.month.toString().padLeft(2, '0')}/${step.time!.year} ${step.time!.hour}:${step.time!.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontFamily: AppFonts.interFamily,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}