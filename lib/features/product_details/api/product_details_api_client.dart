import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../core/api_constants/api_endpoints.dart';
import '../../categories/data/models/product_dto.dart';

part 'product_details_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ProductDetailsApiClient {
  @factoryMethod
  factory ProductDetailsApiClient(Dio dio) = _ProductDetailsApiClient;

  @GET('${ApiEndpoints.getProductdetails}/{id}')
  Future<ProductDto> getProductDetails(@Path('id') String id);
}