import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/core/api_constants/api_endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../data/models/order_dto.dart';

part 'orders_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class OrdersApiClient {
  @factoryMethod
  factory OrdersApiClient(Dio dio) = _OrdersApiClient;

  @GET(ApiEndpoints.getUserOrders)
  Future<OrdersListDto> getUserOrders();

  @POST(ApiEndpoints.createCashOrder)
  Future<CashOrderResponseDto> createCashOrder(
      @Body() Map<String, dynamic> body,
      );

  @POST(ApiEndpoints.checkoutSession)
  Future<CheckoutSessionDto> checkoutSession(
      @Query('url') String redirectUrl,
      @Body() Map<String, dynamic> body,
      );
}
