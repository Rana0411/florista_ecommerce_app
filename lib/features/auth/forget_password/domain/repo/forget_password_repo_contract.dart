
import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/data/models/responses/forget_password_response.dart';

abstract class ForgetPasswordRepoContract {

  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(Map<String, dynamic> body);
}