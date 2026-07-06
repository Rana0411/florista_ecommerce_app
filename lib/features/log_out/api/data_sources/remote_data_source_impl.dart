import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/log_out/api/api_client/api_client.dart';
import 'package:florista_ecommerce_app/features/log_out/data/data_sources/remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/log_out/data/models/message_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogOutRemoteDataSourceContract)
class LogOutRemoteDataSourceImpl implements LogOutRemoteDataSourceContract {
  final ApiClient apiClient;

  LogOutRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<BaseResponse<MessageResponseModel>> logOut() async {
    try {
      final response = await apiClient.logOut();
      return SuccessBaseResponse<MessageResponseModel>(data: response);
    } catch (e) {
      return ErrorBaseResponse<MessageResponseModel>(
        errorMessage: e.toString(),
      );
    }
  }
}
