import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/user_data/user_request_dto.dart';
import 'package:florista_ecommerce_app/features/edit_profile/domain/repo/edit_profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadProfileDataUseCase {
  final EditProfileRepoContract editProfileRepoContract;

  UploadProfileDataUseCase({required this.editProfileRepoContract});

  Future<BaseResponse<UserRequestDto>> call({
    required UserRequestDto userRequestDto,
  }) {
    return editProfileRepoContract.uploadProfileData(
      userRequestDto: userRequestDto,
    );
  }
}
