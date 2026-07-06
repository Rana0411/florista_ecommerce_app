import 'package:florista_ecommerce_app/features/notifications/domain/entity/notification_type_extension.dart';

class NotificationEntity {
  final String id;
  final String title;
  final String body;
  final NotificationType type;
  final String? imageUrl;
  final Map<String, dynamic> data;
  final DateTime receivedAt;
  final bool isRead;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    this.imageUrl,
    required this.data,
    required this.receivedAt,
    this.isRead = false,
  });

  NotificationEntity copyWith({bool? isRead}) {
    return NotificationEntity(
      id: id,
      title: title,
      body: body,
      type: type,
      imageUrl: imageUrl,
      data: data,
      receivedAt: receivedAt,
      isRead: isRead ?? this.isRead,
    );
  }
}
