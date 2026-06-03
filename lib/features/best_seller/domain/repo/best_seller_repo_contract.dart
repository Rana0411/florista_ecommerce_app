import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/categories/domain/entities/product_entity.dart';

abstract interface class BestSellerRepoContract {
  Future<BaseResponse<List<ProductEntity>>> getBestSeller();
}