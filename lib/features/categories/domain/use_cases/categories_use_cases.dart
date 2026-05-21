import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/categories/domain/repo/categories_repo_contract.dart';
import 'package:injectable/injectable.dart';

import '../entities/categories-entity.dart';

@injectable
class GetCategoriesUseCase {
  final CategoriesRepoContract categoriesRepoContract;

  GetCategoriesUseCase({
    required this.categoriesRepoContract,
  });

  Future<BaseResponse<List<CategoryEntity>>> call() async {
    return categoriesRepoContract.getCategories();
  }
}