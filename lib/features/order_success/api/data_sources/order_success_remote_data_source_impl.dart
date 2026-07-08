import 'package:injectable/injectable.dart';

import '../../data/data_sources/order_success_remote_data_source_contract.dart';
import '../../data/models/order_success_dto.dart';
import '../api_client/order_success_api_client.dart';

@Injectable(as: OrderSuccessRemoteDataSourceContract)
class OrderSuccessRemoteDataSourceImpl
    implements OrderSuccessRemoteDataSourceContract {
  OrderSuccessRemoteDataSourceImpl(this._apiClient);

  final OrderSuccessApiClient _apiClient;

  @override
  Future<OrderSuccessDto> getOrderSuccessDetails(String orderId) async {
    final json = await _apiClient.getOrderSuccessDetails(orderId);
    return OrderSuccessDto.fromJson(json);
  }
}