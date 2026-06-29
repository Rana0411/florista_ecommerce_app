import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/order_tracking_entity.dart';

class OrderTrackingDoc {
  final String id;
  final String orderId;
  final String status;
  final Timestamp? estimatedArrival;
  final String? driverName;
  final String? driverPhone;
  final Timestamp? receivedAt;
  final Timestamp? preparingAt;
  final Timestamp? outForDeliveryAt;
  final Timestamp? deliveredAt;

  OrderTrackingDoc({
    required this.id,
    required this.orderId,
    required this.status,
    this.estimatedArrival,
    this.driverName,
    this.driverPhone,
    this.receivedAt,
    this.preparingAt,
    this.outForDeliveryAt,
    this.deliveredAt,
  });

  factory OrderTrackingDoc.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return OrderTrackingDoc(
      id: doc.id,
      orderId: data['orderId'] ?? '',
      status: data['status'] ?? 'received',
      estimatedArrival: data['estimatedArrival'],
      driverName: data['driverName'],
      driverPhone: data['driverPhone'],
      receivedAt: data['receivedAt'],
      preparingAt: data['preparingAt'],
      outForDeliveryAt: data['outForDeliveryAt'],
      deliveredAt: data['deliveredAt'],
    );
  }

  OrderTrackingEntity toEntity() {
    OrderTrackingStatus mapStatus(String s) {
      switch (s.toLowerCase()) {
        case 'preparing':
        case 'start deliver':
          return OrderTrackingStatus.preparingYourOrder;
        case 'out':
        case 'arrived to user':
          return OrderTrackingStatus.outForDelivery;
        case 'delivered':
          return OrderTrackingStatus.delivered;
        default:
          return OrderTrackingStatus.receivedYourOrder;
      }
    }

    return OrderTrackingEntity(
      id: id,
      orderId: orderId,
      status: mapStatus(status),
      estimatedArrival: estimatedArrival?.toDate(),
      driverName: driverName,
      driverPhone: driverPhone,
      receivedAt: receivedAt?.toDate(),
      preparingAt: preparingAt?.toDate(),
      outForDeliveryAt: outForDeliveryAt?.toDate(),
      deliveredAt: deliveredAt?.toDate(),
    );
  }
}