import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/order_tracking_snapshot.dart';

/// Streams real-time driver/timeline updates for a single order, written
/// by the Tracking App into Firestore. Replaces the previous approach of
/// polling `GET /orders` (the whole list) every 15s and doing a client
/// side `firstWhere` — this listens to exactly one document and only
/// wakes up when that document actually changes.
class TrackOrderRemoteDataSource {
  TrackOrderRemoteDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<OrderTrackingSnapshot> watchOrderTracking(String orderId) {
    return _firestore
        .collection('orders')
        .doc(orderId)
        .snapshots()
        .map(OrderTrackingSnapshot.fromSnapshot);
  }
}
