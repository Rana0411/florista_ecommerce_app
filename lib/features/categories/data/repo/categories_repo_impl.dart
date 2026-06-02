import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/categories/data/data_sources/categories_remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/categories/domain/repo/categories_repo_contract.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/shared_models/categories/categories_response.dart';
import '../../domain/entities/categories-entity.dart';

@Injectable(as: CategoriesRepoContract)
class CategoriesRepoImpl implements CategoriesRepoContract {
  final CategoriesRemoteDataSourceContract
  categoriesRemoteDataSourceContract;

  CategoriesRepoImpl({
    required this.categoriesRemoteDataSourceContract,
  });

  @override
  Future<BaseResponse<List<CategoryEntity>>> getCategories() async {
    final response =
    await categoriesRemoteDataSourceContract.getCategories();

    switch (response) {
      case SuccessBaseResponse<CategoriesResponse>():
        return SuccessBaseResponse<List<CategoryEntity>>(
          data:
          response.data.categories
              ?.map((e) => e.toDomain())
              .toList() ??
              [],
        );

      case ErrorBaseResponse<CategoriesResponse>():
        return ErrorBaseResponse<List<CategoryEntity>>(
          errorMessage: response.errorMessage,
        );
    }
  }
}