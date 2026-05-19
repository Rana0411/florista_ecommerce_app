import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/addresses/address_dto.dart';
import 'package:florista_ecommerce_app/config/shared_models/best_seller/best_seller_dto.dart';
import 'package:florista_ecommerce_app/config/shared_models/categories/category_dto.dart';
import 'package:florista_ecommerce_app/config/shared_models/occasions/occasion_dto.dart';
import 'package:florista_ecommerce_app/features/home/data/data_sources/home_remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/address_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/best_seller_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/category_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/occasion_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/repo/home_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepoContract)
class HomeRepoImpl implements HomeRepoContract {
  final HomeRemoteDataSourceContract homeRemoteDataSourceContract;

  HomeRepoImpl({required this.homeRemoteDataSourceContract});
  @override
  Future<BaseResponse<List<CategoryEntity>>> getAllCategories() async {
    final response = await homeRemoteDataSourceContract.getAllCategories();
    switch (response) {
      case SuccessBaseResponse<List<CategoryDto>>():
        return SuccessBaseResponse<List<CategoryEntity>>(
          data: response.data.map((dto) => dto.toHomeDomain()).toList(),
        );
      case ErrorBaseResponse<List<CategoryDto>>():
        return ErrorBaseResponse<List<CategoryEntity>>(
          errorMessage: response.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<List<BestSellerEntity>>> getAllBestSeller() async {
    final response = await homeRemoteDataSourceContract.getAllBestSeller();
    switch (response) {
      case SuccessBaseResponse<List<BestSellerDto>>():
        return SuccessBaseResponse<List<BestSellerEntity>>(
          data: response.data.map((dto) => dto.toHomeDomain()).toList(),
        );
      case ErrorBaseResponse<List<BestSellerDto>>():
        return ErrorBaseResponse<List<BestSellerEntity>>(
          errorMessage: response.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<List<OccasionEntity>>> getAllOccasions() async {
    final response = await homeRemoteDataSourceContract.getAllOccasions();
    switch (response) {
      case SuccessBaseResponse<List<OccasionDto>>():
        return SuccessBaseResponse<List<OccasionEntity>>(
          data: response.data.map((dto) => dto.toHomeDomain()).toList(),
        );
      case ErrorBaseResponse<List<OccasionDto>>():
        return ErrorBaseResponse<List<OccasionEntity>>(
          errorMessage: response.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<List<AddressEntity>>> getLoggedUserAddresses({
    required String token,
  }) async {
    final response = await homeRemoteDataSourceContract.getLoggedUserAddresses(
      token: token,
    );
    switch (response) {
      case SuccessBaseResponse<List<AddressDto>>():
        return SuccessBaseResponse<List<AddressEntity>>(
          data: response.data.map((dto) => dto.toHomeDomain()).toList(),
        );
      case ErrorBaseResponse<List<AddressDto>>():
        return ErrorBaseResponse<List<AddressEntity>>(
          errorMessage: response.errorMessage,
        );
    }
  }
}
