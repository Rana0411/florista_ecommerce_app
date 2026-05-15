import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/occasions/data/models/occasion_dto/occasion_dto_model.dart';
import 'package:florista_ecommerce_app/features/occasions/data/models/product_dto/product_dto.dart';

abstract interface class RemoteDataSourceContract {
  Future<BaseResponse<List<OccasionDto>>> getAllOccasions();
  Future<BaseResponse<List<ProductDto>>> getProductsOfOccasion(
    String occasionId,
  );
}
