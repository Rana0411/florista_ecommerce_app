import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/categories/api/api_client/products_api_client.dart';
import 'package:florista_ecommerce_app/features/categories/data/data_sources/products_remote_data_source_contract.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/responsess/products_response.dart';


@Injectable(as: ProductsRemoteDataSourceContract)
class ProductsRemoteDataSourceImpl
    implements ProductsRemoteDataSourceContract {
  final ProductsApiClient _productsApiClient;

  ProductsRemoteDataSourceImpl({
    required ProductsApiClient productsApiClient,
  }) : _productsApiClient = productsApiClient;

  @override
  Future<BaseResponse<ProductsResponse>> getProductsByCategory(
      String categoryId) async {
    try {
      final response =
          await _productsApiClient.getProductsByCategory(categoryId);
      return SuccessBaseResponse<ProductsResponse>(data: response);
    } catch (e) {
      return ErrorBaseResponse<ProductsResponse>(error: e);
    }
  }
}
