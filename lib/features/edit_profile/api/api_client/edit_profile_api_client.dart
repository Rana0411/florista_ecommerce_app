import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/config/shared_models/user_data/user_data_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/user_data/user_request_dto.dart';
import 'package:florista_ecommerce_app/core/api_constants/api_endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'edit_profile_api_client.g.dart';

@LazySingleton()
@RestApi()
abstract class EditProfileApiClient {
  @factoryMethod
  factory EditProfileApiClient(Dio dio) = _EditProfileApiClient;

  @PUT(ApiEndpoints.editProfile)
  Future<UserDataReponse> editProfile({
    @Body() required UserRequestDto userRequestDto,
  });
}
