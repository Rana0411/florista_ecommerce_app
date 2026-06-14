import 'package:florista_ecommerce_app/features/product_details/api/product_details_api_client.dart';
import 'package:injectable/injectable.dart';

import '../../categories/domain/entities/product_entity.dart';
import '../data/data_source/product_details_remote_data_source_contract.dart';

@LazySingleton(
  as: ProductDetailsRemoteDataSourceContract,
)
class ProductDetailsRemoteDataSourceImpl
    implements ProductDetailsRemoteDataSourceContract {

  final ProductDetailsApiClient apiClient;

  ProductDetailsRemoteDataSourceImpl(
      this.apiClient,
      );

  @override
  Future<ProductEntity> getProductDetails(
      String productId,
      ) async {
    final response =
    await apiClient.getProductDetails(productId);

    return response.toDomain();
  }
}