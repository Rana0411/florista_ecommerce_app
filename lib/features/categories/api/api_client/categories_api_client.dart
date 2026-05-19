import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/core/api_constants/api_endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../config/shared_models/categories/categories_response.dart';

part 'categories_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class CategoriesApiClient {
  @factoryMethod
  factory CategoriesApiClient(Dio dio) = _CategoriesApiClient;

  @GET(ApiEndpoints.getCategories)
  Future<CategoriesResponse> getCategories();
}