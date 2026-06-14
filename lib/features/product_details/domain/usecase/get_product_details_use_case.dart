import 'package:injectable/injectable.dart';

import '../../../categories/domain/entities/product_entity.dart';
import '../repo/product_details_repo_contract.dart';

@injectable
class GetProductDetailsUseCase {
  final ProductDetailsRepoContract repo;

  GetProductDetailsUseCase(this.repo);

  Future<ProductEntity> call(
      String productId,
      ) {
    return repo.getProductDetails(productId);
  }
}