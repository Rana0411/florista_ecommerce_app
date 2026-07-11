import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/map/data/models/map_path_model.dart';

abstract interface class MapRepoContract {
  Future<BaseResponse<List<MapPathModel>>> getRoutePoints({
    required String coordinates,
  });
}
