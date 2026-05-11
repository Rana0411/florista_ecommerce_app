import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/categories/category_dto.dart';
import 'package:florista_ecommerce_app/features/home/data/data_sources/home_remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/category_entity.dart';
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
}
