import 'package:equatable/equatable.dart';

import '../../domain/entities/notification_entity.dart';

class NotificationsState extends Equatable {
  final bool isLoading;
  final List<NotificationEntity> notifications;
  final int unreadCount;
  final String? errorMessage;

  const NotificationsState({
    this.isLoading = false,
    this.notifications = const [],
    this.unreadCount = 0,
    this.errorMessage,
  });

  NotificationsState copyWith({
    bool? isLoading,
    List<NotificationEntity>? notifications,
    int? unreadCount,
    String? errorMessage,
    bool clearError = false,
  }) {
    return NotificationsState(
      isLoading: isLoading ?? this.isLoading,
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, notifications, unreadCount, errorMessage];
}
