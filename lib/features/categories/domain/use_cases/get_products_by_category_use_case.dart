import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/categories/domain/entities/product_entity.dart';
import 'package:florista_ecommerce_app/features/categories/domain/repo/products_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsByCategoryUseCase {
  final ProductsRepoContract _productsRepoContract;

  GetProductsByCategoryUseCase({
    required ProductsRepoContract productsRepoContract,
  }) : _productsRepoContract = productsRepoContract;

  Future<BaseResponse<List<ProductEntity>>> call(String categoryId) {
    return _productsRepoContract.getProductsByCategory(categoryId);
  }
}
