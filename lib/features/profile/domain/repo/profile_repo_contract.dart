import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/profile/domain/entities/user_data_entity.dart';

abstract interface class ProfileRepoContract {
  Future<BaseResponse<UserDataEntity>> getUserData();
}
