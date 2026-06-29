import 'package:florista_ecommerce_app/features/notifications/domain/entity/notification_entity.dart';

abstract class NotificationRepoContract {
  /// Returns all stored notifications, newest first.
  Future<List<NotificationEntity>> getNotifications();

  /// Saves a notification received from FCM.
  Future<void> saveNotification(NotificationEntity notification);

  /// Marks a single notification as read.
  Future<void> markAsRead(String notificationId);

  /// Marks all notifications as read.
  Future<void> markAllAsRead();

  /// Deletes a notification by id.
  Future<void> deleteNotification(String notificationId);

  /// Clears all notifications.
  Future<void> clearAll();

  /// Returns the number of unread notifications.
  Future<int> getUnreadCount();
}
