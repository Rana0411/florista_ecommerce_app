import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/core/api_constants/api_endpoints.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderSuccessApiClient {
  OrderSuccessApiClient(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> getOrderSuccessDetails(String orderId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.orderDetails(orderId),
    );

    return response.data ?? <String, dynamic>{};
  }
}