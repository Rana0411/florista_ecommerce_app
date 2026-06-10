
import '../domain/entities/notification_entity.dart';

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String type;
  final String? imageUrl;
  final Map<String, dynamic> data;
  final DateTime receivedAt;
  final bool isRead;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    this.imageUrl,
    required this.data,
    required this.receivedAt,
    required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: json['type'] as String? ?? 'general',
      imageUrl: json['imageUrl'] as String?,
      data: Map<String, dynamic>.from(json['data'] as Map? ?? {}),
      receivedAt: DateTime.parse(json['receivedAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'type': type,
    'imageUrl': imageUrl,
    'data': data,
    'receivedAt': receivedAt.toIso8601String(),
    'isRead': isRead,
  };

  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
      type: entity.type.name,
      imageUrl: entity.imageUrl,
      data: entity.data,
      receivedAt: entity.receivedAt,
      isRead: entity.isRead,
    );
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title,
      body: body,
      type: NotificationTypeX.fromString(type),
      imageUrl: imageUrl,
      data: data,
      receivedAt: receivedAt,
      isRead: isRead,
    );
  }

  NotificationModel copyWith({bool? isRead}) => NotificationModel(
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
