import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/categories/domain/entities/product_entity.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_souurces/best_seller_remote_data_source_contract.dart';
import '../../data/models/best_seller_dto.dart';
import '../../domain/repo/best_seller_repo_contract.dart';

@Injectable(as: BestSellerRepoContract)
class BestSellerRepoImpl implements BestSellerRepoContract {
  final BestSellerRemoteDataSourceContract _dataSource;

  BestSellerRepoImpl({
    required BestSellerRemoteDataSourceContract dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<BaseResponse<List<ProductEntity>>> getBestSeller() async {
    final response = await _dataSource.getBestSeller();

    switch (response) {
      case SuccessBaseResponse<BestSellerDto>():
        return SuccessBaseResponse<List<ProductEntity>>(
          data: response.data.bestSeller
              ?.map((dto) => dto.toDomain())
              .toList() ??
              [],
        );

      case ErrorBaseResponse<BestSellerDto>():
        return ErrorBaseResponse<List<ProductEntity>>(
          errorMessage: response.errorMessage,
        );
    }
  }
}