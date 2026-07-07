import '../entities/order_success_entity.dart';

abstract class OrderSuccessRepoContract {
  Future<OrderSuccessEntity> getOrderSuccessDetails(String orderId);
}