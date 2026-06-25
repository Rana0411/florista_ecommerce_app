import 'package:equatable/equatable.dart';

enum OrderStatus { active, completed, cancelled, pending }

class OrderItemEntity extends Equatable {
  final String productId;
  final String productName;
  final String imageUrl;
  final int quantity;
  final double price;

  const OrderItemEntity({
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object?> get props =>
      [productId, productName, imageUrl, quantity, price];
}

class OrderEntity extends Equatable {
  final String id;
  final String orderNumber;
  final List<OrderItemEntity> items;
  final double totalPrice;
  final OrderStatus status;
  final DateTime? deliveredAt;
  final DateTime createdAt;

  const OrderEntity({
    required this.id,
    required this.orderNumber,
    required this.items,
    required this.totalPrice,
    required this.status,
    this.deliveredAt,
    required this.createdAt,
  });

  bool get isActive =>
      status == OrderStatus.active || status == OrderStatus.pending;

  bool get isCompleted => status == OrderStatus.completed;

  OrderItemEntity? get firstItem => items.isNotEmpty ? items.first : null;

  @override
  List<Object?> get props =>
      [id, orderNumber, items, totalPrice, status, deliveredAt, createdAt];
}
