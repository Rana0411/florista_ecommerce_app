import 'package:florista_ecommerce_app/core/app_keys/api_keys.dart';

class LoginRequestModel {
  final String email;
  final String password;

  const LoginRequestModel({
    required this.email,
    required this.password,
  });

  /// Uses [ApiKeys] — never bare string literals.
  Map<String, dynamic> toJson() => {
    ApiKeys.email: email,
    ApiKeys.password: password,
  };
}
