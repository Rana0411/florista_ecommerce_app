import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/categories/data/data_sources/products_remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/categories/data/models/responsess/products_response.dart';
import 'package:florista_ecommerce_app/features/categories/domain/entities/product_entity.dart';
import 'package:florista_ecommerce_app/features/categories/domain/repo/products_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRepoContract)
class ProductsRepoImpl implements ProductsRepoContract {
  final ProductsRemoteDataSourceContract _productsRemoteDataSourceContract;

  ProductsRepoImpl({
    required ProductsRemoteDataSourceContract productsRemoteDataSourceContract,
  }) : _productsRemoteDataSourceContract = productsRemoteDataSourceContract;

  @override
  Future<BaseResponse<List<ProductEntity>>> getProductsByCategory(
      String categoryId) async {
    final response = await _productsRemoteDataSourceContract
        .getProductsByCategory(categoryId);

    switch (response) {
      case SuccessBaseResponse<ProductsResponse>():
        return SuccessBaseResponse<List<ProductEntity>>(
          data: response.data.products
                  ?.map((e) => e.toDomain())
                  .toList() ??
              [],
        );

      case ErrorBaseResponse<ProductsResponse>():
        return ErrorBaseResponse<List<ProductEntity>>(
          errorMessage: response.errorMessage,
        );
    }
  }
}
