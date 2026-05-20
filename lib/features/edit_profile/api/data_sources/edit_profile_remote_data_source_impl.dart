import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/user_data/user_data_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/user_data/user_request_dto.dart';
import 'package:florista_ecommerce_app/features/edit_profile/api/api_client/edit_profile_api_client.dart';
import 'package:florista_ecommerce_app/features/edit_profile/data/data_sources/edit_profile_remote_data_source_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRemoteDataSourceContract)
class EditProfileRemoteDataSourceImpl
    implements EditProfileRemoteDataSourceContract {
  final EditProfileApiClient editProfileApiClient;

  EditProfileRemoteDataSourceImpl({required this.editProfileApiClient});
  @override
  Future<BaseResponse<UserDataReponse>> editProfile({
    required UserRequestDto userRequestDto,
  }) async {
    try {
      final response = await editProfileApiClient.editProfile(
        userRequestDto: userRequestDto,
      );
      return SuccessBaseResponse<UserDataReponse>(data: response);
    } catch (e) {
      return ErrorBaseResponse<UserDataReponse>(error: e);
    }
  }
}
