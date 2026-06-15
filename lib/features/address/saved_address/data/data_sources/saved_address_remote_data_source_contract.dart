import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/addresses/address_dto.dart';

abstract interface class SavedAddressRemoteDataSourceContract {
  Future<BaseResponse<List<AddressDto>>> getSavedAddresses();

  Future<BaseResponse<List<AddressDto>>> deleteAddress({
    required String addressId,
  });
}
