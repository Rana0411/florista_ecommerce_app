import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/core/api_constants/api_endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../data/models/responsess/products_response.dart';


part 'products_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ProductsApiClient {
  @factoryMethod
  factory ProductsApiClient(Dio dio) = _ProductsApiClient;

  @GET(ApiEndpoints.getProducts)
  Future<ProductsResponse> getProductsByCategory(
    @Query('category') String categoryId,
  );
}
