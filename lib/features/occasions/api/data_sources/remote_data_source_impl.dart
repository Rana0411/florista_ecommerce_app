import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/occasions/api/api_client/api_client.dart';
import 'package:florista_ecommerce_app/features/occasions/data/data_sources/remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/occasions/data/models/occasion_dto/occasion_dto_model.dart';
import 'package:florista_ecommerce_app/features/occasions/data/models/product_dto/product_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteDataSourceContract)
class RemoteDataSourceImpl implements RemoteDataSourceContract {
  final ApiClient apiClient;

  RemoteDataSourceImpl({required this.apiClient});
  @override
  Future<BaseResponse<List<OccasionDto>>> getAllOccasions() async {
    try {
      final response = await apiClient.getAllOccasions();
      return SuccessBaseResponse<List<OccasionDto>>(data: response.occasions);
    } catch (e) {
      return ErrorBaseResponse(errorMessage: e.toString());
    }
  }

  @override
  Future<BaseResponse<List<ProductDto>>> getProductsOfOccasion(
    String occasionId,
  ) async {
    try {
      final response = await apiClient.getProductsOfOccassion(occasionId);
      return SuccessBaseResponse<List<ProductDto>>(data: response.products);
    } catch (e) {
      return ErrorBaseResponse<List<ProductDto>>(errorMessage: e.toString());
    }
  }
}
