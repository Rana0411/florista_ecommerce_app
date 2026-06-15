import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/address_entity.dart';
import 'package:injectable/injectable.dart';

import '../repo/saved_address_repo_contract.dart';

@injectable
class GetSavedAddressesUseCase {
  final SavedAddressRepoContract savedAddressRepoContract;

  GetSavedAddressesUseCase({required this.savedAddressRepoContract});

  Future<BaseResponse<List<AddressEntity>>> call() {
    return savedAddressRepoContract.getSavedAddresses();
  }
}
