import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/addresses/address_dto.dart';
import 'package:florista_ecommerce_app/config/shared_models/best_seller/best_seller_dto.dart';
import 'package:florista_ecommerce_app/config/shared_models/categories/category_dto.dart';
import 'package:florista_ecommerce_app/config/shared_models/occasions/occasion_dto.dart';
import 'package:florista_ecommerce_app/features/home/api/api_client/home_api_client.dart';
import 'package:florista_ecommerce_app/features/home/data/data_sources/home_remote_data_source_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSourceContract)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSourceContract {
  final HomeApiClient homeApiClient;

  HomeRemoteDataSourceImpl({required this.homeApiClient});
  @override
  Future<BaseResponse<List<CategoryDto>>> getAllCategories() async {
    try {
      final response = await homeApiClient.getAllCategories();
      return SuccessBaseResponse<List<CategoryDto>>(
        data: response.categories ?? [],
      );
    } catch (e) {
      return ErrorBaseResponse<List<CategoryDto>>(error: e);
    }
  }

  @override
  Future<BaseResponse<List<BestSellerDto>>> getAllBestSeller() async {
    try {
      final response = await homeApiClient.getAllBestSeller();
      return SuccessBaseResponse<List<BestSellerDto>>(
        data: response.bestSeller ?? [],
      );
    } catch (e) {
      return ErrorBaseResponse<List<BestSellerDto>>(error: e);
    }
  }

  @override
  Future<BaseResponse<List<OccasionDto>>> getAllOccasions() async {
    try {
      final response = await homeApiClient.getAllOccasions();
      return SuccessBaseResponse<List<OccasionDto>>(
        data: response.occasions ?? [],
      );
    } catch (e) {
      return ErrorBaseResponse<List<OccasionDto>>(error: e);
    }
  }

  @override
  Future<BaseResponse<List<AddressDto>>> getLoggedUserAddresses() async {
    try {
      final response = await homeApiClient.getLoggedUserAddresses();
      return SuccessBaseResponse<List<AddressDto>>(
        data: response.addresses ?? [],
      );
    } catch (e) {
      return ErrorBaseResponse<List<AddressDto>>(error: e);
    }
  }
}
