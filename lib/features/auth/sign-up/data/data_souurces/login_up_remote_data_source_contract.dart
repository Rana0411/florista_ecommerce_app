import 'package:florista_ecommerce_app/config/base_response/base_response.dart';

import '../models/sign_up_dto.dart';

abstract class SignUpRemoteDataSourceContract {
  Future<BaseResponse<SignUpDto>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
    required String gender,
  });
}