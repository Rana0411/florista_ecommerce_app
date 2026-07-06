import 'package:flutter/material.dart';

import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/track_order/domain/entities/track_order_entities.dart';
import 'package:florista_ecommerce_app/features/track_order/presentation/utils/track_date_formatter.dart';

/// A single step row within [TrackOrderTimeline]: a dot + connector line
/// on the left, and the step label/timestamp on the right.
class TimelineRow extends StatelessWidget {
  final TrackTimelineEntry entry;
  final bool isLast;

  const TimelineRow({super.key, required this.entry, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final color = entry.isCompleted ? AppColors.primary : AppColors.lightGrey;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIndicator(color),
          const SizedBox(width: 14),
          Expanded(child: _buildLabel()),
        ],
      ),
    );
  }

  Widget _buildIndicator(Color color) {
    return Column(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: entry.isCompleted ? AppColors.primary : Colors.white,
            border: Border.all(color: color, width: 2),
          ),
          child: entry.isCompleted
              ? const Icon(Icons.circle, size: 8, color: Colors.white)
              : null,
        ),
        if (!isLast)
          Expanded(
            child: Container(
              width: 2,
              color: entry.isCompleted
                  ? AppColors.primary
                  : AppColors.lightGrey.withOpacity(0.4),
            ),
          ),
      ],
    );
  }

  Widget _buildLabel() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entry.step.label,
            style: TextStyle(
              fontFamily: AppFonts.interFamily,
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.semiBold,
              color: entry.isCompleted ? AppColors.black : AppColors.lightGrey,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            entry.timestamp != null ? formatTrackDate(entry.timestamp!) : '--',
            style: TextStyle(
              fontFamily: AppFonts.interFamily,
              fontSize: FontSize.s12,
              color: AppColors.lightGrey,
            ),
          ),
        ],
      ),
    );
  }
}
