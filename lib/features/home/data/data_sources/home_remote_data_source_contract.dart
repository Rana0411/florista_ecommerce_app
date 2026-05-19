import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/addresses/address_dto.dart';
import 'package:florista_ecommerce_app/config/shared_models/best_seller/best_seller_dto.dart';
import 'package:florista_ecommerce_app/config/shared_models/categories/category_dto.dart';
import 'package:florista_ecommerce_app/config/shared_models/occasions/occasion_dto.dart';

abstract interface class HomeRemoteDataSourceContract {
  Future<BaseResponse<List<CategoryDto>>> getAllCategories();
  Future<BaseResponse<List<BestSellerDto>>> getAllBestSeller();
  Future<BaseResponse<List<OccasionDto>>> getAllOccasions();
  Future<BaseResponse<List<AddressDto>>> getLoggedUserAddresses({
    required String token,
  });
}
