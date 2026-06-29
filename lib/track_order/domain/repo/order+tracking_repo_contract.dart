import '../entities/order_tracking_entity.dart';

abstract class OrderTrackingRepository {
  Stream<OrderTrackingEntity?> watchOrderTracking(String orderId);
}