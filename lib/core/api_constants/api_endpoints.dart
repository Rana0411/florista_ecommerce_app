import 'package:florista_ecommerce_app/core/api_constants/base_urls.dart';

abstract class ApiEndpoints {
  static const String _baseUrl = BaseUrls.flowerAppBaseURl;
  static const String signUp = BaseUrls.flowerSignUP;


  static const _AuthEndpoints auth = _AuthEndpoints();
}

class _AuthEndpoints {
  const _AuthEndpoints();

  /// POST  /auth/signin  — body: { email, password }
  static const String signIn = '/auth/signin';
  static const String signUp = '/auth/signup';

  /// POST  /auth/forgotPassword
  static const String forgotPassword = '/auth/forgotPassword';

  /// POST  /auth/verifyResetCode
  static const String verifyResetCode = '/auth/verifyResetCode';

  /// PUT   /auth/resetPassword
  static const String resetPassword = '/auth/resetPassword';
}