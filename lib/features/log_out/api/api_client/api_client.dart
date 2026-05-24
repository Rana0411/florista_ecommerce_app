import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/core/api_constants/api_endpoints.dart';
import 'package:florista_ecommerce_app/features/log_out/data/models/message_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ApiClient {
  @FactoryMethod()
  factory ApiClient(Dio dio) = _ApiClient;

  @GET(ApiEndpoints.logOut)
  Future<MessageResponseModel> logOut();
}
