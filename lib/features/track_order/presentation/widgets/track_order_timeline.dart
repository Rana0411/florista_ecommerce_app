import 'package:flutter/material.dart';

import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/track_order/domain/entities/track_order_entities.dart';

const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String formatTrackDate(DateTime dt) {
  final day = dt.day.toString().padLeft(2, '0');
  final month = _months[dt.month - 1];
  final hour = dt.hour.toString().padLeft(2, '0');
  final minute = dt.minute.toString().padLeft(2, '0');
  return '$day $month ${dt.year} - $hour:$minute';
}

class TrackOrderTimeline extends StatelessWidget {
  final List<TrackTimelineEntry> entries;

  const TrackOrderTimeline({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(entries.length, (index) {
        final entry = entries[index];
        final isLast = index == entries.length - 1;
        return _TimelineRow(entry: entry, isLast: isLast);
      }),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  final TrackTimelineEntry entry;
  final bool isLast;

  const _TimelineRow({required this.entry, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final color = entry.isCompleted ? AppColors.primary : AppColors.lightGrey;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
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
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
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
                      color: entry.isCompleted
                          ? AppColors.black
                          : AppColors.lightGrey,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    entry.timestamp != null
                        ? formatTrackDate(entry.timestamp!)
                        : '--',
                    style: TextStyle(
                      fontFamily: AppFonts.interFamily,
                      fontSize: FontSize.s12,
                      color: AppColors.lightGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
