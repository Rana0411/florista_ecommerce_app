enum NotificationType {
  /// New order placed by the user
  orderPlaced,

  /// Order is being prepared
  orderProcessing,

  /// Order has been shipped
  orderShipped,

  /// Order has been delivered
  orderDelivered,

  /// Order was cancelled
  orderCancelled,

  /// A new promotional offer
  promotion,

  /// Flash sale started
  flashSale,

  /// Item back in stock
  backInStock,

  /// App update or announcement
  general,
}

extension NotificationTypeX on NotificationType {
  static NotificationType fromString(String? value) {
    switch (value) {
      case 'order_placed':
        return NotificationType.orderPlaced;
      case 'order_processing':
        return NotificationType.orderProcessing;
      case 'order_shipped':
        return NotificationType.orderShipped;
      case 'order_delivered':
        return NotificationType.orderDelivered;
      case 'order_cancelled':
        return NotificationType.orderCancelled;
      case 'promotion':
        return NotificationType.promotion;
      case 'flash_sale':
        return NotificationType.flashSale;
      case 'back_in_stock':
        return NotificationType.backInStock;
      default:
        return NotificationType.general;
    }
  }
}
