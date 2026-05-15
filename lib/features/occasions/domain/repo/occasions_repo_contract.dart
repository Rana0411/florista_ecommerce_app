import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/models/product_entity.dart';
import 'package:florista_ecommerce_app/features/occasions/domain/models/occasion_entity.dart';

abstract interface class OccasionsRepoContract {
  Future<BaseResponse<List<OccasionEntity>>> getAllOccasions();
  Future<BaseResponse<List<ProductEntity>>> getproductsOfOccasions(
    String occasionId,
  );
}
