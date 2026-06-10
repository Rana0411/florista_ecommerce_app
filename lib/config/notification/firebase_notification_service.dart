import 'dart:convert';
import 'package:flutter/material.dart' show Color;
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

import '../../features/notifications/domain/entities/notification_entity.dart';
import '../../features/notifications/domain/usecase/notification_use_case.dart';

// ─── Notification channel ────────────────────────────────────────────────────
const _channelId = 'florista_high_importance';
const _channelName = 'Florista Notifications';
const _channelDesc = 'Order updates, promotions and general alerts';

// ─── Background handler (top-level, outside any class) ───────────────────────
// This runs in a separate isolate — DI is not available here.
// FCM will auto-display the notification from its own notification payload.
// We only need to ensure Firebase is initialized.
@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('[FCM] Background message: ${message.messageId} title=${message.notification?.title}',
      name: 'Notif');
  // Android will auto-show the system notification from the FCM payload.
  // Saving to SharedPreferences here is not needed — the app will save it
  // when the user taps the notification and the app opens (onMessageOpenedApp).
}

// ─── Service ─────────────────────────────────────────────────────────────────
@lazySingleton
class FirebaseNotificationService {
  FirebaseNotificationService(this._saveNotification);

  final SaveNotificationUseCase _saveNotification;
  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // 1. Register background handler FIRST
    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

    // 2. Request permission (shows dialog on Android 13+ and iOS)
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    log('[FCM] Permission status: ${settings.authorizationStatus}', name: 'Notif');

    // 3. Initialize flutter_local_notifications
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    await _localNotifications.initialize(
      const InitializationSettings(android: androidSettings, iOS: iosSettings),
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    // 4. Create high-importance Android channel
    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
      const AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDesc,
        importance: Importance.max,        // MAX so it shows as heads-up banner
        playSound: true,
        enableVibration: true,
        showBadge: true,
      ),
    );

    // 5. iOS foreground presentation
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // 6. Foreground messages — show heads-up banner + save
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);

    // 7. Background tap — app was in background, user tapped notification
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageTap);

    // 8. Terminated tap — app was closed, user tapped notification
    final initial = await _messaging.getInitialMessage();
    if (initial != null) {
      log('[FCM] App opened from terminated via notification', name: 'Notif');
      await _onMessageTap(initial);
    }

    // 9. Log the FCM token (copy from debug console for Firebase Console testing)
    final token = await _messaging.getToken();
    log('[FCM] Token: $token', name: 'Notif');
  }

  // ─── Foreground: show heads-up banner + save ────────────────────────────────
  Future<void> _onForegroundMessage(RemoteMessage message) async {
    log('[FCM] Foreground message: ${message.notification?.title}', name: 'Notif');
    await _saveMessage(message);

    final notif = message.notification;
    if (notif == null) return;

    // Show as a system heads-up notification banner
    await _localNotifications.show(
      message.hashCode,
      notif.title,
      notif.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          color: const Color(0xFFD21E6A),
          playSound: true,
          enableVibration: true,
          styleInformation: BigTextStyleInformation(notif.body ?? ''),
          // Show as heads-up banner (peek notification)
          fullScreenIntent: false,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }

  // ─── Tap handlers ───────────────────────────────────────────────────────────
  Future<void> _onMessageTap(RemoteMessage message) async {
    log('[FCM] Notification tapped: ${message.notification?.title}', name: 'Notif');
    await _saveMessage(message);
  }

  void _onNotificationTap(NotificationResponse response) {
    log('[FCM] Local notification tapped payload=${response.payload}', name: 'Notif');
    // Navigate to notifications screen if needed
  }

  // ─── Save to storage ────────────────────────────────────────────────────────
  Future<void> _saveMessage(RemoteMessage message) async {
    final notif = message.notification;
    final title = notif?.title ?? message.data['title'] as String? ?? '';
    final body = notif?.body ?? message.data['body'] as String? ?? '';
    if (title.isEmpty && body.isEmpty) return;

    await _saveNotification(
      NotificationEntity(
        id: message.messageId ?? DateTime.now().toIso8601String(),
        title: title,
        body: body,
        type: NotificationTypeX.fromString(message.data['type'] as String?),
        imageUrl: notif?.android?.imageUrl ??
            notif?.apple?.imageUrl ??
            message.data['imageUrl'] as String?,
        data: Map<String, dynamic>.from(message.data),
        receivedAt: message.sentTime ?? DateTime.now(),
        isRead: false,
      ),
    );
  }

  Future<String?> getToken() => _messaging.getToken();
}
