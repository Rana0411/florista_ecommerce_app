import 'package:injectable/injectable.dart';

import '../entities/order_success_entity.dart';
import '../repo/order_success_repo_contract.dart';

@injectable
class GetOrderSuccessDetailsUseCase {
  GetOrderSuccessDetailsUseCase(this._repo);

  final OrderSuccessRepoContract _repo;

  Future<OrderSuccessEntity> call(String orderId) {
    return _repo.getOrderSuccessDetails(orderId);
  }
}