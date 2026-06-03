import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/address_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/repo/home_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetLoggedUserAddressesUseCase {
  final HomeRepoContract homeRepoContract;

  GetLoggedUserAddressesUseCase({required this.homeRepoContract});

  Future<BaseResponse<List<AddressEntity>>> call() {
    return homeRepoContract.getLoggedUserAddresses();
  }
}
