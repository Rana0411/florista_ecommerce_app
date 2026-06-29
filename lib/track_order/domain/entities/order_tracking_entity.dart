import 'package:equatable/equatable.dart';

enum OrderTrackingStatus {
  receivedYourOrder,
  preparingYourOrder,
  outForDelivery,
  delivered,
}

class OrderTrackingEntity extends Equatable {
  final String id;
  final String orderId;
  final OrderTrackingStatus status;
  final DateTime? estimatedArrival;
  final String? driverName;
  final String? driverPhone;
  final DateTime? receivedAt;
  final DateTime? preparingAt;
  final DateTime? outForDeliveryAt;
  final DateTime? deliveredAt;

  const OrderTrackingEntity({
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

  @override
  List<Object?> get props => [
    id,
    orderId,
    status,
    estimatedArrival,
    driverName,
    driverPhone,
    receivedAt,
    preparingAt,
    outForDeliveryAt,
    deliveredAt,
  ];
}