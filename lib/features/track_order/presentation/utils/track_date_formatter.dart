const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

/// Formats a [DateTime] as e.g. "05 Jul 2026 - 14:30" for the
/// Track Order screen and timeline.
String formatTrackDate(DateTime dt) {
  final day = dt.day.toString().padLeft(2, '0');
  final month = _months[dt.month - 1];
  final hour = dt.hour.toString().padLeft(2, '0');
  final minute = dt.minute.toString().padLeft(2, '0');
  return '$day $month ${dt.year} - $hour:$minute';
}
