import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/config/shared_models/user_data/user_data_response.dart';
import 'package:florista_ecommerce_app/core/api_constants/api_endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'profile_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio) = _ProfileApiClient;

  @GET(ApiEndpoints.getUserData)
  Future<UserDataReponse> getUserData();
}
