import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/address/add_address/data/models/responsess/add_address_response.dart';

abstract class AddAddressRemoteDataSourceContract {
  Future<BaseResponse<AddAddressResponse>> addAddress(
      Map<String, dynamic> body);

  Future<BaseResponse<AddAddressResponse>> getAddresses();
}
