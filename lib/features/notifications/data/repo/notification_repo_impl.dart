import 'dart:convert';
import 'dart:developer';
import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/secure_storage/secure_storage_service.dart';
import 'package:florista_ecommerce_app/features/notifications/data/models/notification_model.dart';
import 'package:florista_ecommerce_app/features/notifications/domain/entity/notification_entity.dart';
import 'package:florista_ecommerce_app/features/notifications/domain/repo/notification_repo_contract.dart';
import 'package:injectable/injectable.dart';

const _kNotificationsKey = 'florista_notifications';

@LazySingleton(as: NotificationRepoContract)
class NotificationRepoImpl implements NotificationRepoContract {
  final SecureStorageService _secureStorage;

  NotificationRepoImpl(this._secureStorage); // ← Dependency Injection

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    try {
      final result = await _secureStorage.read(key: _kNotificationsKey);
      if (result is ErrorBaseResponse) return [];

      final raw = (result as SuccessBaseResponse<String>).data;
      log('[NotificationRepo] getNotifications → raw=$raw', name: 'Notif');

      final list = jsonDecode(raw) as List<dynamic>;
      final notifications =
          list
              .map(
                (e) => NotificationModel.fromJson(
                  e as Map<String, dynamic>,
                ).toEntity(),
              )
              .toList()
            ..sort((a, b) => b.receivedAt.compareTo(a.receivedAt));

      log(
        '[NotificationRepo] getNotifications → count=${notifications.length}',
        name: 'Notif',
      );
      return notifications;
    } catch (e, st) {
      log(
        '[NotificationRepo] getNotifications ERROR: $e',
        name: 'Notif',
        error: e,
        stackTrace: st,
      );
      return [];
    }
  }

  @override
  Future<int> getUnreadCount() async {
    final notifications = await getNotifications();
    return notifications.where((n) => !n.isRead).length;
  }

  @override
  Future<void> saveNotification(NotificationEntity notification) async {
    try {
      log(
        '[NotificationRepo] saveNotification id=${notification.id} title=${notification.title}',
        name: 'Notif',
      );

      final current = await _loadModels();
      current.removeWhere((n) => n.id == notification.id);
      current.insert(0, NotificationModel.fromEntity(notification));
      await _persist(current);

      // Verify it was saved
      final saved = await _secureStorage.read(key: _kNotificationsKey);
      if (saved is SuccessBaseResponse<String>) {
        log(
          '[NotificationRepo] saveNotification done, stored length=${saved.data.length}',
          name: 'Notif',
        );
      }
    } catch (e, st) {
      log(
        '[NotificationRepo] saveNotification ERROR: $e',
        name: 'Notif',
        error: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    final current = await _loadModels();
    final updated = current
        .map((n) => n.id == notificationId ? n.copyWith(isRead: true) : n)
        .toList();
    await _persist(updated);
  }

  @override
  Future<void> markAllAsRead() async {
    final current = await _loadModels();
    final updated = current.map((n) => n.copyWith(isRead: true)).toList();
    await _persist(updated);
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    final current = await _loadModels();
    current.removeWhere((n) => n.id == notificationId);
    await _persist(current);
  }

  @override
  Future<void> clearAll() async {
    await _secureStorage.delete(key: _kNotificationsKey);
  }

  // ─── Private Helpers ────────────────────────────────────────────────────────

  Future<List<NotificationModel>> _loadModels() async {
    final result = await _secureStorage.read(key: _kNotificationsKey);
    if (result is ErrorBaseResponse) return [];

    final raw = (result as SuccessBaseResponse<String>).data;
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> _persist(List<NotificationModel> models) async {
    final encoded = jsonEncode(models.map((m) => m.toJson()).toList());
    await _secureStorage.write(key: _kNotificationsKey, value: encoded);
    log(
      '[NotificationRepo] _persist → saved ${models.length} models',
      name: 'Notif',
    );
  }
}
