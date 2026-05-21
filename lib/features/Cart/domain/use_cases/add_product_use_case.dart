import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_requests_model.dart';
import 'package:florista_ecommerce_app/features/cart/domain/models/cart_response_entity.dart';
import 'package:florista_ecommerce_app/features/cart/domain/repo/cart_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddProductUseCase {
  final CartRepoContract cartRepoContract;
  AddProductUseCase({required this.cartRepoContract});

  Future<BaseResponse<CartResponseEntity>> call(
    AddProductRequest productInfo,
  ) async {
    return await cartRepoContract.addProductToCart(productInfo);
  }
}
