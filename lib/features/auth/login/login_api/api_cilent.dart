import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/features/auth/login/data/model/login_request_model.dart';
import 'package:florista_ecommerce_app/features/auth/login/data/model/login_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part "api_client.g.dart";

// Retrofit annotations require compile-time constants.
// These mirror ApiEndpoints exactly — single source of truth stays in ApiEndpoints.
const _signIn = '/auth/signin';
const _signUp = '/auth/signup';
const _forgotPassword = '/auth/forgotPassword';
const _verifyResetCode = '/auth/verifyResetCode';
const _resetPassword = '/auth/resetPassword';

@singleton
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  // ── Auth ──────────────────────────────────────────────────────────────────

  @POST(_signIn)
  Future<LoginResponseModel> login(@Body() LoginRequestModel request);

  @POST(_signUp)
  Future<LoginResponseModel> signUp(@Body() LoginRequestModel request);

  @POST(_forgotPassword)
  Future<LoginResponseModel> forgotPassword(
      @Field('email') String email,
      );

  @POST(_verifyResetCode)
  Future<LoginResponseModel> verifyResetCode(
      @Field('resetCode') String resetCode,
      );

  @PUT(_resetPassword)
  Future<LoginResponseModel> resetPassword(
      @Field('email') String email,
      @Field('newPassword') String newPassword,
      );
}