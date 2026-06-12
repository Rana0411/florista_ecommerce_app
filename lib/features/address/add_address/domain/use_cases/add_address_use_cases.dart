import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/address/add_address/data/models/responsess/add_address_response.dart';
import 'package:florista_ecommerce_app/features/address/add_address/domain/repo/add_address_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddAddressUseCase {
  final AddAddressRepoContract addAddressRepo;

  AddAddressUseCase({required this.addAddressRepo});

  Future<BaseResponse<AddAddressResponse>> call(
    Map<String, dynamic> body,
  ) async {
    return await addAddressRepo.addAddress(body);
  }
}

@injectable
class GetAddressesUseCase {
  final AddAddressRepoContract addAddressRepo;

  GetAddressesUseCase({required this.addAddressRepo});

  Future<BaseResponse<AddAddressResponse>> call() async {
    return await addAddressRepo.getAddresses();
  }
}
