
import '../models/order_success_dto.dart';

abstract class OrderSuccessRemoteDataSourceContract {
  Future<OrderSuccessDto> getOrderSuccessDetails(String orderId);
}