import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/core/api_constants/api_endpoints.dart';
import 'package:florista_ecommerce_app/features/payment/data/models/stripe_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';

@RestApi()
@lazySingleton
abstract class ApiClient {
  @FactoryMethod()
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(ApiEndpoints.checkoutSession)
  Future<StripeResponse?> createCheckoutSession(
    @Body() Map<String, dynamic> request,
    @Query("url") String url,
  );
}
