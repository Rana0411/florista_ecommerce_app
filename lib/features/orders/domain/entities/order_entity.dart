import 'package:equatable/equatable.dart';

enum OrderStatus { active, completed, cancelled, pending }

/// The 4 granular driver actions that map 1-to-1 to the user-visible
/// timeline steps. The Tracking App writes this into Firestore; Florista
/// reads it and derives the timeline from it instead of from [OrderStatus].
///
/// null  → driver has not yet taken any action (order just accepted)
/// [arrivedAtPickup]  → driver "Arrived at pickup point"
/// [startDeliver]     → driver "Start deliver"
/// [arrivedToUser]    → driver "Arrived to the user"
/// [delivered]        → driver "Delivered to the user"
enum DriverStatus {
  arrivedAtPickup,
  startDeliver,
  arrivedToUser,
  delivered,
}

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

  // ── Driver / tracking fields ──────────────────────────────────────────────
  /// The driver's current granular status, written by the Tracking App into
  /// Firestore and mapped here. Null until the driver takes the first action.
  final DriverStatus? driverStatus;

  /// Real timestamps for each driver action, populated as the driver
  /// progresses. Null until that specific action happens.
  final DateTime? arrivedAtPickupAt;
  final DateTime? startDeliverAt;
  final DateTime? arrivedToUserAt;

  /// Real name of the assigned driver (comes from the Tracking App /
  /// Firestore). Null until a driver accepts the order.
  final String? driverName;

  /// Real phone number of the assigned driver.
  final String? driverPhone;

  /// Asset path or network URL for the driver's avatar.
  final String? driverAvatarAsset;

  const OrderEntity({
    required this.id,
    required this.orderNumber,
    required this.items,
    required this.totalPrice,
    required this.status,
    this.deliveredAt,
    required this.createdAt,
    this.driverStatus,
    this.arrivedAtPickupAt,
    this.startDeliverAt,
    this.arrivedToUserAt,
    this.driverName,
    this.driverPhone,
    this.driverAvatarAsset,
  });

  bool get isActive =>
      status == OrderStatus.active || status == OrderStatus.pending;

  bool get isCompleted => status == OrderStatus.completed;

  OrderItemEntity? get firstItem => items.isNotEmpty ? items.first : null;

  @override
  List<Object?> get props => [
    id,
    orderNumber,
    items,
    totalPrice,
    status,
    deliveredAt,
    createdAt,
    driverStatus,
    arrivedAtPickupAt,
    startDeliverAt,
    arrivedToUserAt,
    driverName,
    driverPhone,
    driverAvatarAsset,
  ];
}
