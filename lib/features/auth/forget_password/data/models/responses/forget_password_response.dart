import 'package:json_annotation/json_annotation.dart';

part 'forget_password_response.g.dart';

@JsonSerializable()
class ForgetPasswordResponse {
  final String? message;
  final String? status;
  final int? code;
  final String? info;
  final String? token;

  ForgetPasswordResponse({
    this.message,
    this.code,
    this.info,
    this.token,
    this.status,
  });

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordResponseToJson(this);
}
