import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_sources/orders_remote_data_source_contract.dart';
import '../../data/models/order_dto.dart';
import '../../domain/entities/order_entity.dart';
import '../api_client/orders_api_client.dart';

@Injectable(as: OrdersRemoteDataSourceContract)
class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSourceContract {
  final OrdersApiClient _apiClient;
  OrdersRemoteDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<List<OrderEntity>>> getUserOrders() async {
    try {
      final dto = await _apiClient.getUserOrders();
      final orders = dto.orders?.map((o) => o.toDomain()).toList() ?? [];
      return SuccessBaseResponse(data: orders);
    } catch (e) {
      return ErrorBaseResponse(error: e);
    }
  }

  @override
  Future<BaseResponse<String>> checkoutSession(
      String cartId, String shippingAddress) async {
    try {
      final dto = await _apiClient.checkoutSession(
          'http://localhost:3000',
          {
            'cartId': cartId,
            'shippingAddress': shippingAddress,
          });
      return SuccessBaseResponse(data: dto.session ?? '');
    } catch (e) {
      return ErrorBaseResponse(error: e);
    }
  }

  @override
  Future<BaseResponse<OrderEntity>> createCashOrder(
      String cartId, String shippingAddress) async {
    try {
      final response = await _apiClient.createCashOrder({
        'cartId': cartId,
        'shippingAddress': shippingAddress,
      });
      final dto = response.order ?? OrderDto.fromJson(response.raw);
      return SuccessBaseResponse(data: dto.toDomain());
    } catch (e) {
      return ErrorBaseResponse(error: e);
    }
  }
}
