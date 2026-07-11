import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/map/data/models/map_path_response_model.dart';

abstract class MapRemoteDataSourceContract {
  Future<BaseResponse<MapPathResponseModel>> getRoutePoints({
    required String coordinates,
  });
}
