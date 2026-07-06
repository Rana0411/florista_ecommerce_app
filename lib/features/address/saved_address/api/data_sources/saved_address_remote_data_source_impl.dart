import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/addresses/address_dto.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_sources/saved_address_remote_data_source_contract.dart';
import '../api_client/saved_address_api_client.dart';

@Injectable(as: SavedAddressRemoteDataSourceContract)
class SavedAddressRemoteDataSourceImpl
    implements SavedAddressRemoteDataSourceContract {
  final SavedAddressApiClient savedAddressApiClient;

  SavedAddressRemoteDataSourceImpl({required this.savedAddressApiClient});

  @override
  Future<BaseResponse<List<AddressDto>>> getSavedAddresses() async {
    try {
      final response = await savedAddressApiClient.getSavedAddresses();
      return SuccessBaseResponse<List<AddressDto>>(
        data: response.addresses ?? [],
      );
    } catch (e) {
      return ErrorBaseResponse<List<AddressDto>>(error: e);
    }
  }

  @override
  Future<BaseResponse<List<AddressDto>>> deleteAddress({
    required String addressId,
  }) async {
    try {
      final response = await savedAddressApiClient.deleteAddress(
        addressId: addressId,
      );
      return SuccessBaseResponse<List<AddressDto>>(
        data: response.addresses ?? [],
      );
    } catch (e) {
      return ErrorBaseResponse<List<AddressDto>>(error: e);
    }
  }
}
