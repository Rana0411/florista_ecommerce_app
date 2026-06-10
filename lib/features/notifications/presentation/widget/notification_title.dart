import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/notification_entity.dart';

class NotificationTile extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUnread = !notification.isRead;

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: isUnread
              ? const Color(0xffD21E6A).withOpacity(0.05)
              : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon badge
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _iconBackground(notification.type),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _iconData(notification.type),
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: isUnread
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isUnread)
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(left: 6),
                            decoration: const BoxDecoration(
                              color: Color(0xffD21E6A),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.body,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: const Color(0xff535353),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _formatTime(notification.receivedAt),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: const Color(0xffA6A6A6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('MMM d').format(dt);
  }

  Color _iconBackground(NotificationType type) {
    switch (type) {
      case NotificationType.orderPlaced:
        return const Color(0xff5B73E8);
      case NotificationType.orderProcessing:
        return const Color(0xffF1A545);
      case NotificationType.orderShipped:
        return const Color(0xff50A5F1);
      case NotificationType.orderDelivered:
        return const Color(0xff0CB359);
      case NotificationType.orderCancelled:
        return const Color(0xffB3261E);
      case NotificationType.promotion:
      case NotificationType.flashSale:
        return const Color(0xffD21E6A);
      case NotificationType.backInStock:
        return const Color(0xff0CB359);
      case NotificationType.general:
        return const Color(0xff535353);
    }
  }

  IconData _iconData(NotificationType type) {
    switch (type) {
      case NotificationType.orderPlaced:
        return Icons.receipt_long_outlined;
      case NotificationType.orderProcessing:
        return Icons.inventory_2_outlined;
      case NotificationType.orderShipped:
        return Icons.local_shipping_outlined;
      case NotificationType.orderDelivered:
        return Icons.check_circle_outline;
      case NotificationType.orderCancelled:
        return Icons.cancel_outlined;
      case NotificationType.promotion:
        return Icons.local_offer_outlined;
      case NotificationType.flashSale:
        return Icons.bolt_outlined;
      case NotificationType.backInStock:
        return Icons.shopping_bag_outlined;
      case NotificationType.general:
        return Icons.notifications_outlined;
    }
  }
}
