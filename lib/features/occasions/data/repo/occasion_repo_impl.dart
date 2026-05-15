import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/models/product_entity.dart';
import 'package:florista_ecommerce_app/features/occasions/data/data_sources/remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/occasions/data/models/occasion_dto/occasion_dto_model.dart';
import 'package:florista_ecommerce_app/features/occasions/data/models/product_dto/product_dto.dart';
import 'package:florista_ecommerce_app/features/occasions/domain/models/occasion_entity.dart';
import 'package:florista_ecommerce_app/features/occasions/domain/repo/occasions_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OccasionsRepoContract)
class OccasionRepoImpl implements OccasionsRepoContract {
  RemoteDataSourceContract remoteDataSourceContract;

  OccasionRepoImpl({required this.remoteDataSourceContract});

  @override
  Future<BaseResponse<List<OccasionEntity>>> getAllOccasions() async {
    final response = await remoteDataSourceContract.getAllOccasions();

    switch (response) {
      case SuccessBaseResponse<List<OccasionDto>>():
        return SuccessBaseResponse<List<OccasionEntity>>(
          data: response.data
              .map((occasion) => occasion.toDomain(occasion))
              .toList(),
        );

      case ErrorBaseResponse<List<OccasionDto>>():
        return ErrorBaseResponse<List<OccasionEntity>>(
          errorMessage: response.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<List<ProductEntity>>> getproductsOfOccasions(
    String occasionId,
  ) async {
    final response = await remoteDataSourceContract.getProductsOfOccasion(
      occasionId,
    );
    switch (response) {
      case SuccessBaseResponse<List<ProductDto>>():
        return SuccessBaseResponse<List<ProductEntity>>(
          data: response.data
              .map((product) => product.toDomain(product))
              .toList(),
        );
      case ErrorBaseResponse<List<ProductDto>>():
        return ErrorBaseResponse<List<ProductEntity>>(
          errorMessage: response.errorMessage,
        );
    }
  }
}
