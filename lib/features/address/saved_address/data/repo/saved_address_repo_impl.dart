import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/addresses/address_dto.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/address_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo/saved_address_repo_contract.dart';
import '../data_sources/saved_address_remote_data_source_contract.dart';

@Injectable(as: SavedAddressRepoContract)
class SavedAddressRepoImpl implements SavedAddressRepoContract {
  final SavedAddressRemoteDataSourceContract
  savedAddressRemoteDataSourceContract;

  SavedAddressRepoImpl({required this.savedAddressRemoteDataSourceContract});

  @override
  Future<BaseResponse<List<AddressEntity>>> getSavedAddresses() async {
    final response = await savedAddressRemoteDataSourceContract
        .getSavedAddresses();
    switch (response) {
      case SuccessBaseResponse<List<AddressDto>>():
        return SuccessBaseResponse<List<AddressEntity>>(
          data: response.data.map((dto) => dto.toHomeDomain()).toList(),
        );
      case ErrorBaseResponse<List<AddressDto>>():
        return ErrorBaseResponse<List<AddressEntity>>(
          errorMessage: response.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<List<AddressEntity>>> deleteAddress({
    required String addressId,
  }) async {
    final response = await savedAddressRemoteDataSourceContract.deleteAddress(
      addressId: addressId,
    );
    switch (response) {
      case SuccessBaseResponse<List<AddressDto>>():
        return SuccessBaseResponse<List<AddressEntity>>(
          data: response.data.map((dto) => dto.toHomeDomain()).toList(),
        );
      case ErrorBaseResponse<List<AddressDto>>():
        return ErrorBaseResponse<List<AddressEntity>>(
          errorMessage: response.errorMessage,
        );
    }
  }
}
