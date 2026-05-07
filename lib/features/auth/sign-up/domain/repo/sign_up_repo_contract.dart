import 'package:florista_ecommerce_app/config/base_response/base_response.dart';

import '../models/user_entity.dart';

abstract class SignUpRepoContract {
  Future<BaseResponse<UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  });
}