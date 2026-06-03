import 'package:florista_ecommerce_app/config/base_response/base_response.dart';

import '../entities/product_entity.dart';

abstract interface class ProductsRepoContract {
  Future<BaseResponse<List<ProductEntity>>> getProductsByCategory(
      String categoryId);
}
