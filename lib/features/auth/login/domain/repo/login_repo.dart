import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/auth/login/domain/entity/login_entity.dart';

abstract class LoginRepo {
  Future<BaseResponse<LoginEntity>> login({
    required String email,
    required String password,
  });
}