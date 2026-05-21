import 'package:florista_ecommerce_app/config/base_response/base_response.dart';

import '../../data/models/responsess/products_response.dart';

abstract interface class ProductsRemoteDataSourceContract {
  Future<BaseResponse<ProductsResponse>> getProductsByCategory(
      String categoryId);
}
