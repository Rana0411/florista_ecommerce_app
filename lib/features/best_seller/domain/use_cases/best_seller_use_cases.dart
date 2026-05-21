import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/categories/domain/entities/product_entity.dart';
import 'package:injectable/injectable.dart';

import '../repo/best_seller_repo_contract.dart';

@injectable
class GetBestSellerUseCase {
  final BestSellerRepoContract _bestSellerRepoContract;

  GetBestSellerUseCase({
    required BestSellerRepoContract bestSellerRepoContract,
  }) : _bestSellerRepoContract = bestSellerRepoContract;

  Future<BaseResponse<List<ProductEntity>>> call() {
    return _bestSellerRepoContract.getBestSeller();
  }
}