import 'package:flutter/material.dart';

import 'package:florista_ecommerce_app/features/track_order/domain/entities/track_order_entities.dart';
import 'package:florista_ecommerce_app/features/track_order/presentation/widgets/timeline_row.dart';

export 'package:florista_ecommerce_app/features/track_order/presentation/utils/track_date_formatter.dart'
    show formatTrackDate;

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
        return TimelineRow(entry: entry, isLast: isLast);
      }),
    );
  }
}
