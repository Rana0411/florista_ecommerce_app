import 'package:florista_ecommerce_app/config/base_response/error_base_response_extention.dart';
import 'package:flutter/material.dart';

sealed class BaseResponse<T> {}

class SuccessBaseResponse<T> extends BaseResponse<T> {
  T data;
  SuccessBaseResponse({required this.data});
}

class ErrorBaseResponse<T> extends BaseResponse<T> {
  final Object? error;
  final String? errorMessage;

  ErrorBaseResponse({this.error, this.errorMessage});

  String getErrorMessage(BuildContext context) =>
      handleErrorMessage(context, error);
}
