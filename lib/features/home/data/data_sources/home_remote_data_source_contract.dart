import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/categories/category_dto.dart';

abstract interface class HomeRemoteDataSourceContract {
  Future<BaseResponse<List<CategoryDto>>> getAllCategories();
}
