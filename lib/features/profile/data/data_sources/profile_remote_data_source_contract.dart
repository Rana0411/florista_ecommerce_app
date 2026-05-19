import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/user_data/user_data_response.dart';

abstract interface class ProfileRemoteDataSourceContract {
  Future<BaseResponse<UserDataReponse>> getUserData();
}
