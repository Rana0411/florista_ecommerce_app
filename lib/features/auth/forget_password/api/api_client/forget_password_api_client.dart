import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/core/api_constants/api_endpoints.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/data/models/responses/forget_password_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'forget_password_api_client.g.dart';


@RestApi()
@singleton
abstract class ForgetPasswordApiClient {
  @factoryMethod
  factory ForgetPasswordApiClient(Dio dio) = _ForgetPasswordApiClient;

  @POST(ApiEndpoints.forgetPassword)
  Future<ForgetPasswordResponse> forgetPassword(
      {
    @Body() required Map<String, dynamic> body,
  });


  @POST(ApiEndpoints.verifyResetCode)
  Future<ForgetPasswordResponse> confirmValidationCode({
    @Body()  required Map<String, dynamic> body,

  });

  @PUT(ApiEndpoints.resetPassword)
  Future<ForgetPasswordResponse> resetPassword({
    @Body() required Map<String, dynamic> resetPassDto,
  });
}