import 'dart:convert';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/entities/notification_entity.dart';
import '../domain/repo/notification_repo_contract.dart';
import 'notification_models.dart';

const _kNotificationsKey = 'florista_notifications';

@LazySingleton(as: NotificationRepoContract)
class NotificationRepoImpl implements NotificationRepoContract {
  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    try {
      final prefs = await _prefs;
      final raw = prefs.getString(_kNotificationsKey);
      log('[NotificationRepo] getNotifications → raw=$raw', name: 'Notif');
      if (raw == null) return [];
      final list = jsonDecode(raw) as List<dynamic>;
      final result = list
          .map((e) =>
          NotificationModel.fromJson(e as Map<String, dynamic>).toEntity())
          .toList()
        ..sort((a, b) => b.receivedAt.compareTo(a.receivedAt));
      log('[NotificationRepo] getNotifications → count=${result.length}', name: 'Notif');
      return result;
    } catch (e, st) {
      log('[NotificationRepo] getNotifications ERROR: $e', name: 'Notif', error: e, stackTrace: st);
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
      log('[NotificationRepo] saveNotification id=${notification.id} title=${notification.title}', name: 'Notif');
      final current = await _loadModels();
      current.removeWhere((n) => n.id == notification.id);
      current.insert(0, NotificationModel.fromEntity(notification));
      await _persist(current);
      // Verify it was actually saved
      final prefs = await _prefs;
      final saved = prefs.getString(_kNotificationsKey);
      log('[NotificationRepo] saveNotification done, stored length=${saved?.length}', name: 'Notif');
    } catch (e, st) {
      log('[NotificationRepo] saveNotification ERROR: $e', name: 'Notif', error: e, stackTrace: st);
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
    final prefs = await _prefs;
    await prefs.remove(_kNotificationsKey);
  }

  Future<List<NotificationModel>> _loadModels() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_kNotificationsKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> _persist(List<NotificationModel> models) async {
    final prefs = await _prefs;
    final encoded = jsonEncode(models.map((m) => m.toJson()).toList());
    await prefs.setString(_kNotificationsKey, encoded);
    log('[NotificationRepo] _persist → saved ${models.length} models', name: 'Notif');
  }
}
