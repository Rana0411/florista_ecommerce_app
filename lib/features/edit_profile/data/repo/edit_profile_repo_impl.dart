import 'package:dio/src/multipart_file.dart';
import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/user_data/user_data_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/user_data/user_request_dto.dart';
import 'package:florista_ecommerce_app/features/edit_profile/data/data_sources/edit_profile_remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/edit_profile/domain/repo/edit_profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRepoContract)
class EditProfileRepoImpl implements EditProfileRepoContract {
  final EditProfileRemoteDataSourceContract editProfileRemoteDataSourceContract;

  EditProfileRepoImpl({required this.editProfileRemoteDataSourceContract});
  @override
  Future<BaseResponse<UserRequestDto>> editProfile({
    required UserRequestDto userRequestDto,
  }) async {
    final response = await editProfileRemoteDataSourceContract.editProfile(
      userRequestDto: userRequestDto,
    );
    switch (response) {
      case SuccessBaseResponse<UserDataReponse>():
        return SuccessBaseResponse<UserRequestDto>(
          data: response.data.user!.toDomain(),
        );
      case ErrorBaseResponse<UserDataReponse>():
        return ErrorBaseResponse<UserRequestDto>(
          errorMessage: response.getErrorMessage(),
        );
    }
  }

  @override
  Future<BaseResponse<String>> uploadProfilePhoto({
    required MultipartFile photo,
  }) {
    final response = editProfileRemoteDataSourceContract.uploadProfilePhoto(
      photo: photo,
    );
    return response;
  }
}
