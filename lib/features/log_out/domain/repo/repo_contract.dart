import 'package:florista_ecommerce_app/config/base_response/base_response.dart';

abstract interface class LogOutRepoContract {
  Future<BaseResponse<String>> logOut();
}
