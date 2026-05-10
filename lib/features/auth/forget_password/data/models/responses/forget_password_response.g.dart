// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetPasswordResponse _$ForgetPasswordResponseFromJson(
  Map<String, dynamic> json,
) => ForgetPasswordResponse(
  message: json['message'] as String?,
  code: (json['code'] as num?)?.toInt(),
  info: json['info'] as String?,
  token: json['token'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$ForgetPasswordResponseToJson(
  ForgetPasswordResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'status': instance.status,
  'code': instance.code,
  'info': instance.info,
  'token': instance.token,
};
