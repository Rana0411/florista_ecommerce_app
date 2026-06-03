import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/change_password/api/api_client/change_password_api_client.dart';
import 'package:florista_ecommerce_app/features/change_password/data/data_sources/change_password_remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/change_password/data/models/change_password_request.dart';
import 'package:florista_ecommerce_app/features/change_password/data/models/change_password_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordRemoteDataSourceContract)
class ChangePasswordRemoteDataSourceImpl
    implements ChangePasswordRemoteDataSourceContract {
  final ChangePasswordApiClient changePasswordApiClient;

  ChangePasswordRemoteDataSourceImpl({required this.changePasswordApiClient});
  @override
  Future<BaseResponse<ChangePasswordResponse>> changePassword({
    required ChangePasswordRequest passwords,
  }) async {
    try {
      final response = await changePasswordApiClient.changePassword(
        passwords: passwords,
      );
      return SuccessBaseResponse<ChangePasswordResponse>(data: response);
    } catch (e) {
      return ErrorBaseResponse<ChangePasswordResponse>(error: e);
    }
  }
}
