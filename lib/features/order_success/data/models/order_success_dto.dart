import '../../domain/entities/order_success_entity.dart';

class OrderSuccessDto {
  const OrderSuccessDto({
    required this.orderId,
    this.status,
    this.trackingNumber,
  });

  final String orderId;
  final String? status;
  final String? trackingNumber;

  factory OrderSuccessDto.fromJson(Map<String, dynamic> json) {
    return OrderSuccessDto(
      orderId: (json['orderId'] ?? json['_id'] ?? json['id'] ?? '').toString(),
      status: json['status']?.toString(),
      trackingNumber: json['trackingNumber']?.toString(),
    );
  }

  OrderSuccessEntity toEntity() {
    return OrderSuccessEntity(
      orderId: orderId,
      status: status,
      trackingNumber: trackingNumber,
    );
  }
}