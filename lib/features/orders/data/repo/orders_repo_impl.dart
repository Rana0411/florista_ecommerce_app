import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_sources/orders_remote_data_source_contract.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repo/orders_repo_contract.dart';

@Injectable(as: OrdersRepoContract)
class OrdersRepoImpl implements OrdersRepoContract {
  final OrdersRemoteDataSourceContract _dataSource;
  OrdersRepoImpl(this._dataSource);

  @override
  Future<BaseResponse<List<OrderEntity>>> getUserOrders() =>
      _dataSource.getUserOrders();

  @override
  Future<BaseResponse<String>> checkoutSession(
          String cartId, String shippingAddress) =>
      _dataSource.checkoutSession(cartId, shippingAddress);

  @override
  Future<BaseResponse<OrderEntity>> createCashOrder(
          String cartId, String shippingAddress) =>
      _dataSource.createCashOrder(cartId, shippingAddress);
}
