import 'package:florista_ecommerce_app/core/app_keys/api_keys.dart';
import 'package:florista_ecommerce_app/features/auth/login/domain/entity/login_entity.dart';

class LoginResponseModel {
  final String? message;
  final String? token;

  const LoginResponseModel({
    this.message,
    this.token,
  });

  /// Uses [ApiKeys] — never bare string literals.
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        message: json[ApiKeys.message] as String?,
        token: json[ApiKeys.token] as String?,
      );

  LoginEntity toEntity() => LoginEntity(
    message: message,
    token: token,
  );
}
