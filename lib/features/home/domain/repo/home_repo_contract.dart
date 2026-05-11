import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/best_seller_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/category_entity.dart';

abstract interface class HomeRepoContract {
  Future<BaseResponse<List<CategoryEntity>>> getAllCategories();
  Future<BaseResponse<List<BestSellerEntity>>> getAllBestSeller();
}
