import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/entities/product_entity.dart';
import 'package:florista_ecommerce_app/features/occasions/domain/repo/occasions_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsOfOccasion {
  final OccasionsRepoContract repoContract;

  GetProductsOfOccasion({required this.repoContract});

  Future<BaseResponse<List<ProductEntity>>> call(String occasionId) async {
    return await repoContract.getproductsOfOccasions(occasionId);
  }
}
