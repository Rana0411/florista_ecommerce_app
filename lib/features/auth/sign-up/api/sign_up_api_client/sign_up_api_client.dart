import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../data/models/sign_up_dto.dart';

part 'sign_up_api_client.g.dart';

@RestApi()
@singleton
abstract class SignUpApiClient {
  @factoryMethod
  factory SignUpApiClient(Dio dio) = _SignUpApiClient;

  @POST('/auth/signup')
  @FormUrlEncoded()
  Future<SignUpDto> signUp({
    @Field('name') required String name,
    @Field('email') required String email,
    @Field('password') required String password,
    @Field('rePassword') required String rePassword,
    @Field('phone') required String phone,
  });
}