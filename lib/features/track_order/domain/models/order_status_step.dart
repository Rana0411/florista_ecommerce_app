/// Represents a single step inside the order tracking timeline.
///
/// This is a pure presentation model (no business logic / no remote data
/// source) since the Track Order feature is UI-only for now.
class OrderStatusStep {
  final String title;
  final String dateTime;
  final bool isCompleted;

  const OrderStatusStep({
    required this.title,
    required this.dateTime,
    this.isCompleted = false,
  });
}
