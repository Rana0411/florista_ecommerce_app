import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/cart/domain/repo/cart_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClearCartUseCase {
  final CartRepoContract cartRepoContract;
  ClearCartUseCase({required this.cartRepoContract});

  Future<BaseResponse<String>> call() async {
    return await cartRepoContract.clearCart();
  }
}
