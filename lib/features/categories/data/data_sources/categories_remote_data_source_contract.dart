import 'package:florista_ecommerce_app/config/base_response/base_response.dart';

import '../../../../config/shared_models/categories/categories_response.dart';

abstract interface class CategoriesRemoteDataSourceContract {
  Future<BaseResponse<CategoriesResponse>> getCategories();
}