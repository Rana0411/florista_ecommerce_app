import 'package:equatable/equatable.dart';

class OrderSuccessEntity extends Equatable {
  const OrderSuccessEntity({
    required this.orderId,
    this.status,
    this.trackingNumber,
  });

  final String orderId;
  final String? status;
  final String? trackingNumber;

  @override
  List<Object?> get props => [orderId, status, trackingNumber];
}