import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/features/address/add_address/data/models/responsess/add_address_response.dart';
import 'package:florista_ecommerce_app/core/api_constants/api_endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'add_address_api_client.g.dart';

@RestApi()
@singleton
abstract class AddAddressApiClient {
  @factoryMethod
  factory AddAddressApiClient(Dio dio) = _AddAddressApiClient;

  @PATCH(ApiEndpoints.addresses)
  Future<AddAddressResponse> addAddress(
      @Body() Map<String, dynamic> body,
      );

  @GET(ApiEndpoints.addresses)
  Future<AddAddressResponse> getAddresses();
}