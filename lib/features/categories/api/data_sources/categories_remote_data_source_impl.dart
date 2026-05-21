import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/categories/api/api_client/categories_api_client.dart';
import 'package:florista_ecommerce_app/features/categories/data/data_sources/categories_remote_data_source_contract.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/shared_models/categories/categories_response.dart';

@Injectable(as: CategoriesRemoteDataSourceContract)
class CategoriesRemoteDataSourceImpl
    implements CategoriesRemoteDataSourceContract {
  final CategoriesApiClient categoriesApiClient;

  CategoriesRemoteDataSourceImpl({
    required this.categoriesApiClient,
  });

  @override
  Future<BaseResponse<CategoriesResponse>> getCategories() async {
    try {
      final response = await categoriesApiClient.getCategories();

      return SuccessBaseResponse<CategoriesResponse>(
        data: response,
      );
    } catch (e) {
      return ErrorBaseResponse<CategoriesResponse>(
        error: e,
      );
    }
  }
}