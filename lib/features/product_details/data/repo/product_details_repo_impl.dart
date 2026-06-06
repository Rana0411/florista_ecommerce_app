import 'package:injectable/injectable.dart';

import '../../../categories/domain/entities/product_entity.dart';
import '../../domain/repo/product_details_repo_contract.dart';
import '../data_source/product_details_remote_data_source_contract.dart';

@LazySingleton(as: ProductDetailsRepoContract)
class ProductDetailsRepoImpl implements ProductDetailsRepoContract {
  final ProductDetailsRemoteDataSourceContract remoteDataSource;

  ProductDetailsRepoImpl(this.remoteDataSource);

  @override
  Future<ProductEntity> getProductDetails(String productId) {
    return remoteDataSource.getProductDetails(productId);
  }
}
