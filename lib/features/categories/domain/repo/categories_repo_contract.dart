import 'package:florista_ecommerce_app/config/base_response/base_response.dart';

import '../entities/categories-entity.dart';

abstract interface class CategoriesRepoContract {
  Future<BaseResponse<List<CategoryEntity>>> getCategories();
}