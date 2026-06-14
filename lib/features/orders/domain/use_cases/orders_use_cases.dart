import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

import '../entities/order_entity.dart';
import '../repo/orders_repo_contract.dart';

@injectable
class GetUserOrdersUseCase {
  final OrdersRepoContract _repo;
  GetUserOrdersUseCase(this._repo);
  Future<BaseResponse<List<OrderEntity>>> call() => _repo.getUserOrders();
}

@injectable
class CheckoutSessionUseCase {
  final OrdersRepoContract _repo;
  CheckoutSessionUseCase(this._repo);
  Future<BaseResponse<String>> call(String cartId, String shippingAddress) =>
      _repo.checkoutSession(cartId, shippingAddress);
}

@injectable
class CreateCashOrderUseCase {
  final OrdersRepoContract _repo;
  CreateCashOrderUseCase(this._repo);
  Future<BaseResponse<OrderEntity>> call(
          String cartId, String shippingAddress) =>
      _repo.createCashOrder(cartId, shippingAddress);
}
