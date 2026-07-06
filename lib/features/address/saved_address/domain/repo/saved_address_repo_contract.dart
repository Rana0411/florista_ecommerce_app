import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/address_entity.dart';

abstract interface class SavedAddressRepoContract {
  Future<BaseResponse<List<AddressEntity>>> getSavedAddresses();

  Future<BaseResponse<List<AddressEntity>>> deleteAddress({
    required String addressId,
  });
}
