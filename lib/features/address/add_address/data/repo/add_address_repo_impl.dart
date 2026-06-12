import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/address/add_address/data/data_sources/add_address_remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/address/add_address/data/models/responsess/add_address_response.dart';
import 'package:florista_ecommerce_app/features/address/add_address/domain/repo/add_address_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddAddressRepoContract)
class AddAddressRepoImpl implements AddAddressRepoContract {
  final AddAddressRemoteDataSourceContract addAddressRemoteDataSource;

  AddAddressRepoImpl({required this.addAddressRemoteDataSource});

  @override
  Future<BaseResponse<AddAddressResponse>> addAddress(
    Map<String, dynamic> body,
  ) async {
    final response = await addAddressRemoteDataSource.addAddress(body);
    switch (response) {
      case SuccessBaseResponse():
        return SuccessBaseResponse(data: response.data);
      case ErrorBaseResponse():
        return ErrorBaseResponse(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<BaseResponse<AddAddressResponse>> getAddresses() async {
    final response = await addAddressRemoteDataSource.getAddresses();
    switch (response) {
      case SuccessBaseResponse():
        return SuccessBaseResponse(data: response.data);
      case ErrorBaseResponse():
        return ErrorBaseResponse(errorMessage: response.errorMessage);
    }
  }
}
