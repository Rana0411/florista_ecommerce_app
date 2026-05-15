import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/core/api_constants/api_endpoints.dart';
import 'package:florista_ecommerce_app/features/occasions/data/models/all_occasion_response_model.dart';
import 'package:florista_ecommerce_app/features/occasions/data/models/products_response_model/products_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ApiClient {
  @FactoryMethod()
  factory ApiClient(Dio dio) = _ApiClient;

  @GET(ApiEndpoints.allOccasions)
  Future<AllOccasionResponseModel> getAllOccasions();

  @GET(ApiEndpoints.productsOfOccasion)
  Future<ProductsResponseModel> getProductsOfOccassion(
    @Query("occasion") String occasionId,
  );
}
