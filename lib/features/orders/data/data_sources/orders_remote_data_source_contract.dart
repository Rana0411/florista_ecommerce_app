import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import '../../domain/entities/order_entity.dart';

abstract interface class OrdersRemoteDataSourceContract {
  Future<BaseResponse<List<OrderEntity>>> getUserOrders();
  Future<BaseResponse<String>> checkoutSession(String cartId, String shippingAddress);
  Future<BaseResponse<OrderEntity>> createCashOrder(String cartId, String shippingAddress);
}
