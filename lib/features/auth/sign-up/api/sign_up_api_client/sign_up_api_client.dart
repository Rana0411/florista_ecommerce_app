import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/api_constants/api_endpoints.dart';
import '../../data/models/sign_up_dto.dart';

part 'sign_up_api_client.g.dart';

@RestApi()
@singleton
abstract class SignUpApiClient {
  @factoryMethod
  factory SignUpApiClient(Dio dio) = _SignUpApiClient;

  @POST(ApiEndpoints.signUp)
  Future<SignUpDto> signUp(
      @Body() Map<String, dynamic> body,
      );
}