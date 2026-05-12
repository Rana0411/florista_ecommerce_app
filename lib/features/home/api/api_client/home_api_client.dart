import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/config/shared_models/addresses/addresses_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/best_seller/best_seller_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/categories/categories_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/occasions/occasions_response.dart';
import 'package:florista_ecommerce_app/core/api_constants/api_endpoints.dart';
import 'package:florista_ecommerce_app/core/app_keys/api_keys.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'home_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class HomeApiClient {
  @factoryMethod
  factory HomeApiClient(Dio dio) = _HomeApiClient;

  @GET(ApiEndpoints.categories)
  Future<CategoriesResponse> getAllCategories();

  @GET(ApiEndpoints.bestSeller)
  Future<BestSellerResponse> getAllBestSeller();

  @GET(ApiEndpoints.occasions)
  Future<OccasionsResponse> getAllOccasions();

  @GET(ApiEndpoints.addresses)
  Future<AddressesResponse> getLoggedUserAddresses({
    @Header(ApiKeys.authorization) required String token,
  });
}
