import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/features/auth/login/data/model/login_request_model.dart';
import 'package:florista_ecommerce_app/features/auth/login/data/model/login_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

// Retrofit annotations require compile-time constants.
const _signIn = '/auth/signin';

@singleton
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  // ── Auth ────────────────────────────────────────────────────────────────

  @POST(_signIn)
  Future<LoginResponseModel> login(
      @Body() LoginRequestModel request,
      );

}