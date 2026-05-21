import 'package:florista_ecommerce_app/config/base_response/base_response.dart';

import '../models/best_seller_dto.dart';

abstract interface class BestSellerRemoteDataSourceContract {
  Future<BaseResponse<BestSellerDto>> getBestSeller();
}