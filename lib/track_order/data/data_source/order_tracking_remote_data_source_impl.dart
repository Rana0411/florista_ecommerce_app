import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'order_tracking_remote_data_source_contract.dart';
import '../models/order_tracking_doc.dart';
import '../../domain/entities/order_tracking_entity.dart';

@injectable
class OrderTrackingRemoteDataSourceImpl implements OrderTrackingRemoteDataSource {
  final FirebaseFirestore firestore;

  @factoryMethod
  OrderTrackingRemoteDataSourceImpl(this.firestore);

  @override
  Stream<OrderTrackingEntity?> watchOrderTracking(String orderId) {
    return firestore
        .collection('order_tracking')
        .where('orderId', isEqualTo: orderId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;
      final doc = OrderTrackingDoc.fromFirestore(snapshot.docs.first);
      return doc.toEntity();
    });
  }
}