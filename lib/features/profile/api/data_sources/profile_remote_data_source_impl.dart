import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/profile/api/api_client/profile_api_client.dart';
import 'package:florista_ecommerce_app/features/profile/data/data_sources/profile_remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/profile/data/models/responses/user_data_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSourceContract)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSourceContract {
  final ProfileApiClient profileApiClient;

  ProfileRemoteDataSourceImpl({required this.profileApiClient});
  @override
  Future<BaseResponse<UserDataReponse>> getUserData() async {
    try {
      final response = await profileApiClient.getUserData();
      return SuccessBaseResponse<UserDataReponse>(data: response);
    } catch (e) {
      return ErrorBaseResponse<UserDataReponse>(error: e);
    }
  }
}
