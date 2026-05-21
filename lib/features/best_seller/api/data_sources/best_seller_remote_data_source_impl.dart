import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

import '../../api/best_seller_api_client/best_seller_api_client.dart';
import '../../data/models/best_seller_dto.dart';
import '../../data/data_souurces/best_seller_remote_data_source_contract.dart';

@Injectable(as: BestSellerRemoteDataSourceContract)
class BestSellerRemoteDataSourceImpl
    implements BestSellerRemoteDataSourceContract {
  final BestSellerApiClient _apiClient;

  BestSellerRemoteDataSourceImpl({
    required BestSellerApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<BaseResponse<BestSellerDto>> getBestSeller() async {
    try {
      final response = await _apiClient.getBestSeller();
      return SuccessBaseResponse<BestSellerDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<BestSellerDto>(error: e);
    }
  }
}