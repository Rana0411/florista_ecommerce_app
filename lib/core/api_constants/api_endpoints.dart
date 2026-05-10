import 'package:florista_ecommerce_app/core/api_constants/base_urls.dart';

abstract class ApiEndpoints {
  static const String _baseUrl = BaseUrls.flowerAppBaseURl;
  static const String forgetPassword = '$_baseUrl/auth/forgotPassword';
  static const String verifyResetCode = '$_baseUrl/auth/verifyResetCode';
  static const String resetPassword = '$_baseUrl/auth/resetPassword';


  //TODO: app endpoints
}
