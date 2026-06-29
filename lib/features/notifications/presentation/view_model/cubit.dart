import 'dart:developer';

import 'package:florista_ecommerce_app/features/notifications/domain/use_cases/clear_all_notification.dart';
import 'package:florista_ecommerce_app/features/notifications/domain/use_cases/delete_notification_use_case.dart';
import 'package:florista_ecommerce_app/features/notifications/domain/use_cases/get_notification_use_case.dart';
import 'package:florista_ecommerce_app/features/notifications/domain/use_cases/get_unread_notification_count.dart';
import 'package:florista_ecommerce_app/features/notifications/domain/use_cases/mark_all_notification_as_read.dart';
import 'package:florista_ecommerce_app/features/notifications/domain/use_cases/mark_notification_read.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'notification_state.dart';

@injectable
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit({
    required GetNotificationsUseCase getNotifications,
    required MarkNotificationAsReadUseCase markAsRead,
    required MarkAllNotificationsAsReadUseCase markAllAsRead,
    required DeleteNotificationUseCase deleteNotification,
    required ClearAllNotificationsUseCase clearAll,
    required GetUnreadNotificationCountUseCase getUnreadCount,
  }) : _getNotifications = getNotifications,
       _markAsRead = markAsRead,
       _markAllAsRead = markAllAsRead,
       _deleteNotification = deleteNotification,
       _clearAll = clearAll,
       _getUnreadCount = getUnreadCount,
       super(const NotificationsState());

  final GetNotificationsUseCase _getNotifications;
  final MarkNotificationAsReadUseCase _markAsRead;
  final MarkAllNotificationsAsReadUseCase _markAllAsRead;
  final DeleteNotificationUseCase _deleteNotification;
  final ClearAllNotificationsUseCase _clearAll;
  final GetUnreadNotificationCountUseCase _getUnreadCount;

  Future<void> loadNotifications() async {
    log(
      '[NotificationsCubit] loadNotifications called, isClosed=$isClosed',
      name: 'Notif',
    );
    if (isClosed) return;
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final notifications = await _getNotifications();
      log(
        '[NotificationsCubit] loaded ${notifications.length} notifications',
        name: 'Notif',
      );
      if (isClosed) return;
      final unread = notifications.where((n) => !n.isRead).length;
      emit(
        state.copyWith(
          isLoading: false,
          notifications: notifications,
          unreadCount: unread,
        ),
      );
      log(
        '[NotificationsCubit] emitted state with ${notifications.length} items',
        name: 'Notif',
      );
    } catch (e, st) {
      log(
        '[NotificationsCubit] ERROR: $e',
        name: 'Notif',
        error: e,
        stackTrace: st,
      );
      if (!isClosed) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    }
  }

  Future<void> refreshUnreadCount() async {
    final count = await _getUnreadCount();
    if (!isClosed) emit(state.copyWith(unreadCount: count));
  }

  Future<void> markAsRead(String id) async {
    await _markAsRead(id);
    await loadNotifications();
  }

  Future<void> markAllAsRead() async {
    await _markAllAsRead();
    await loadNotifications();
  }

  Future<void> deleteNotification(String id) async {
    await _deleteNotification(id);
    await loadNotifications();
  }

  Future<void> clearAll() async {
    await _clearAll();
    if (!isClosed) {
      emit(state.copyWith(notifications: [], unreadCount: 0));
    }
  }
}
