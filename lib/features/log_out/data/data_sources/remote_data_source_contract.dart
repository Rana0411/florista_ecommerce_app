import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/log_out/data/models/message_response_model.dart';

abstract interface class LogOutRemoteDataSourceContract {
  Future<BaseResponse<MessageResponseModel>> logOut();
}
