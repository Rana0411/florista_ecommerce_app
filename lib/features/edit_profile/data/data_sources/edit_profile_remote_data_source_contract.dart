import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/user_data/user_data_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/user_data/user_request_dto.dart';

abstract interface class EditProfileRemoteDataSourceContract {
  Future<BaseResponse<UserDataReponse>> editProfile({
    required UserRequestDto userRequestDto,
  });
  Future<BaseResponse<String>> uploadProfilePhoto({
    required MultipartFile photo,
  });
}
