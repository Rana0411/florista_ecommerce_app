/// Helper to compute and format estimated delivery times.
class DeliveryTimeHelper {
  /// Returns the estimated arrival DateTime given a delivery duration.
  static DateTime estimatedArrival({
    required Duration deliveryDuration,
    DateTime? from,
  }) {
    return (from ?? DateTime.now()).add(deliveryDuration);
  }

  /// Formats a DateTime as "03 Sep 2024, 11:00 AM" without intl package.
  static String format(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = _monthName(dateTime.month);
    final year = dateTime.year;

    final hour24 = dateTime.hour;
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour24 >= 12 ? 'PM' : 'AM';

    return '$day $month $year, $hour12:$minute $period';
  }

  /// Formats relative to "today" — e.g. "Today, 11:00 AM" / "Tomorrow, 11:00 AM"
  /// or falls back to full date for later days.
  static String formatSmart(DateTime dateTime, {DateTime? now}) {
    final reference = now ?? DateTime.now();
    final today = DateTime(reference.year, reference.month, reference.day);
    final target = DateTime(dateTime.year, dateTime.month, dateTime.day);
    final diff = target.difference(today).inDays;

    final timeStr = _formatTime(dateTime);

    if (diff == 0) return 'Today, $timeStr';
    if (diff == 1) return 'Tomorrow, $timeStr';
    return format(dateTime);
  }

  static String _formatTime(DateTime dateTime) {
    final hour24 = dateTime.hour;
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour24 >= 12 ? 'PM' : 'AM';
    return '$hour12:$minute $period';
  }

  static String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
