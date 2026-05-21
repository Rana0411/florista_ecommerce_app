import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/cart/domain/models/cart_response_entity.dart';
import 'package:florista_ecommerce_app/features/cart/domain/repo/cart_repo_contract.dart';

class RemoveProductUseCase {
  final CartRepoContract cartRepoContract;
  RemoveProductUseCase({required this.cartRepoContract});

  Future<BaseResponse<CartResponseEntity>> call(String productId) async {
    return await cartRepoContract.removeProductFromCart(productId);
  }
}
