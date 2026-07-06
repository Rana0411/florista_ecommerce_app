import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/config/shared_models/addresses/addresses_response.dart';
import 'package:florista_ecommerce_app/core/api_constants/api_endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'saved_address_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class SavedAddressApiClient {
  @factoryMethod
  factory SavedAddressApiClient(Dio dio) = _SavedAddressApiClient;

  @GET(ApiEndpoints.addresses)
  Future<AddressesResponse> getSavedAddresses();

  @DELETE('${ApiEndpoints.addresses}/{addressId}')
  Future<AddressesResponse> deleteAddress({
    @Path('addressId') required String addressId,
  });
}
