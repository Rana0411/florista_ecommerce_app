import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_requests_model.dart';
import 'package:florista_ecommerce_app/features/cart/domain/models/cart_response_entity.dart';
import 'package:florista_ecommerce_app/features/cart/domain/repo/cart_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProductQuantityUseCase {
  final CartRepoContract cartRepoContract;
  UpdateProductQuantityUseCase({required this.cartRepoContract});

  Future<BaseResponse<CartResponseEntity>> call(
    String productId,
    UpdateQuantityRequest quantity,
  ) async {
    return await cartRepoContract.updateProductQuantity(productId, quantity);
  }
}
