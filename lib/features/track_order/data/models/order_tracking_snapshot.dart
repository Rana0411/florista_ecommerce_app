import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:florista_ecommerce_app/features/orders/domain/entities/order_entity.dart';
import 'package:florista_ecommerce_app/features/track_order/domain/entities/track_order_entities.dart';

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
///   shippingAddress    (Map?)     — same shape sent to the backend when
///                                   the order was placed:
///                                     street (String?)
///                                     phone  (String?)
///                                     city   (String?)
///                                     lat    (String? or num?)
///                                     long   (String? or num?)
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
  final TrackOrderShippingAddress shippingAddress;

  const OrderTrackingSnapshot({
    this.driverStatus,
    this.driverName,
    this.driverPhone,
    this.driverAvatarAsset,
    this.arrivedAtPickupAt,
    this.startDeliverAt,
    this.arrivedToUserAt,
    this.deliveredAt,
    this.shippingAddress = const TrackOrderShippingAddress.empty(),
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
        deliveredAt = null,
        shippingAddress = const TrackOrderShippingAddress.empty();

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
      shippingAddress: _parseShippingAddress(data['shippingAddress']),
    );
  }

  static TrackOrderShippingAddress _parseShippingAddress(dynamic raw) {
    if (raw is! Map) return const TrackOrderShippingAddress.empty();
    final map = raw;

    return TrackOrderShippingAddress(
      street: (map['street'] as String?) ?? '',
      city: (map['city'] as String?) ?? '',
      phone: (map['phone'] as String?) ?? '',
      latitude: _parseCoordinate(map['lat']),
      longitude: _parseCoordinate(map['long'] ?? map['lng']),
    );
  }

  static double? _parseCoordinate(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
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
