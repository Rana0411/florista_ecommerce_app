import 'package:injectable/injectable.dart';

import '../../domain/entities/order_success_entity.dart';
import '../../domain/repo/order_success_repo_contract.dart';
import '../data_sources/order_success_remote_data_source_contract.dart';

@Injectable(as: OrderSuccessRepoContract)
class OrderSuccessRepoImpl implements OrderSuccessRepoContract {
  OrderSuccessRepoImpl(this._remoteDataSource);

  final OrderSuccessRemoteDataSourceContract _remoteDataSource;

  @override
  Future<OrderSuccessEntity> getOrderSuccessDetails(String orderId) async {
    final dto = await _remoteDataSource.getOrderSuccessDetails(orderId);
    return dto.toEntity();
  }
}