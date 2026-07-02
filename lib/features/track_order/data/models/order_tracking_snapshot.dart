import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:florista_ecommerce_app/features/orders/domain/entities/order_entity.dart';

/// Parses the Firestore document the Tracking App writes for a single
/// order into the driver/timeline fields Florista needs.
///
/// Expected document path: `orders/{orderId}`, with fields:
///   driverStatus      (String?)   — one of DriverStatus.name
///   driverName        (String?)
///   driverPhone       (String?)
///   driverAvatarUrl   (String?)
///   arrivedAtPickupAt (Timestamp?)
///   startDeliverAt    (Timestamp?)
///   arrivedToUserAt   (Timestamp?)
///   deliveredAt       (Timestamp?)
///
/// NOTE: this schema is inferred from [OrderEntity]'s tracking fields and
/// the doc comments already on that entity ("written by the Tracking App
/// into Firestore"). If the Tracking App uses different field names,
/// update the `json['...']` keys below to match.
class OrderTrackingSnapshot {
  final DriverStatus? driverStatus;
  final String? driverName;
  final String? driverPhone;
  final String? driverAvatarAsset;
  final DateTime? arrivedAtPickupAt;
  final DateTime? startDeliverAt;
  final DateTime? arrivedToUserAt;
  final DateTime? deliveredAt;

  const OrderTrackingSnapshot({
    this.driverStatus,
    this.driverName,
    this.driverPhone,
    this.driverAvatarAsset,
    this.arrivedAtPickupAt,
    this.startDeliverAt,
    this.arrivedToUserAt,
    this.deliveredAt,
  });

  /// Empty snapshot — used while the tracking doc doesn't exist yet
  /// (e.g. driver hasn't been assigned).
  const OrderTrackingSnapshot.empty()
      : driverStatus = null,
        driverName = null,
        driverPhone = null,
        driverAvatarAsset = null,
        arrivedAtPickupAt = null,
        startDeliverAt = null,
        arrivedToUserAt = null,
        deliveredAt = null;

  factory OrderTrackingSnapshot.fromSnapshot(DocumentSnapshot snapshot) {
    if (!snapshot.exists) return const OrderTrackingSnapshot.empty();

    final data = snapshot.data() as Map<String, dynamic>? ?? {};

    return OrderTrackingSnapshot(
      driverStatus: _parseDriverStatus(data['driverStatus'] as String?),
      driverName: data['driverName'] as String?,
      driverPhone: data['driverPhone'] as String?,
      driverAvatarAsset: data['driverAvatarUrl'] as String?,
      arrivedAtPickupAt: _parseTimestamp(data['arrivedAtPickupAt']),
      startDeliverAt: _parseTimestamp(data['startDeliverAt']),
      arrivedToUserAt: _parseTimestamp(data['arrivedToUserAt']),
      deliveredAt: _parseTimestamp(data['deliveredAt']),
    );
  }

  static DriverStatus? _parseDriverStatus(String? raw) {
    if (raw == null) return null;
    for (final status in DriverStatus.values) {
      if (status.name == raw) return status;
    }
    return null;
  }

  static DateTime? _parseTimestamp(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
