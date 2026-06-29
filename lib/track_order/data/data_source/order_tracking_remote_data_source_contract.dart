import '../../domain/entities/order_tracking_entity.dart';

abstract class OrderTrackingRemoteDataSource {
  Stream<OrderTrackingEntity?> watchOrderTracking(String orderId);
}