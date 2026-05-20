import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/edit_profile/domain/repo/edit_profile_repo_contract.dart';

class UploadProfilePhoto {
  final EditProfileRepoContract editProfileRepoContract;

  UploadProfilePhoto({required this.editProfileRepoContract});

  Future<BaseResponse<String>> call({required MultipartFile photo}) {
    return editProfileRepoContract.uploadProfilePhoto(photo: photo);
  }
}
