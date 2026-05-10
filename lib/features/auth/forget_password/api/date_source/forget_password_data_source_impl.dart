import 'dart:async';
import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/api/api_client/forget_password_api_client.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/data/data_source/forget_password_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/data/models/responses/forget_password_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgetPasswordDataSourceContract)
class ForgetPasswordDataSourceImpl implements ForgetPasswordDataSourceContract {
  final ForgetPasswordApiClient forgetPasswordApiClient;

  ForgetPasswordDataSourceImpl({required this.forgetPasswordApiClient});

  @override
  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await forgetPasswordApiClient.forgetPassword(body: body);

      return SuccessBaseResponse<ForgetPasswordResponse>(data: response);
    } catch (e) {
      if (e is DioException) {
        final data = e.response?.data;
        final messageFromApi = (data is Map<String, dynamic>)
            ? data['message']?.toString()
            : null;
        return ErrorBaseResponse<ForgetPasswordResponse>(
          errorMessage:
              messageFromApi ??
              e.message ??
              "Something went wrong. Please try again later.",
        );
      } else if (e is TimeoutException) {
        return ErrorBaseResponse<ForgetPasswordResponse>(
          errorMessage: "Request timed out. Please try again later.",
        );
      }
      return ErrorBaseResponse<ForgetPasswordResponse>(
        errorMessage: "Something went wrong. Please try again later.",
      );
    }
  }

  @override
  Future<BaseResponse<ForgetPasswordResponse>> resetPassword(
      Map<String, dynamic> body,
      ) async {
    try {
      final response = await forgetPasswordApiClient.forgetPassword(body: body);

      return SuccessBaseResponse<ForgetPasswordResponse>(data: response);
    } catch (e) {
      if (e is DioException) {
        final data = e.response?.data;
        final messageFromApi = (data is Map<String, dynamic>)
            ? data['message']?.toString()
            : null;
        return ErrorBaseResponse<ForgetPasswordResponse>(
          errorMessage:
          messageFromApi ??
              e.message ??
              "Something went wrong. Please try again later.",
        );
      } else if (e is TimeoutException) {
        return ErrorBaseResponse<ForgetPasswordResponse>(
          errorMessage: "Request timed out. Please try again later.",
        );
      }
      return ErrorBaseResponse<ForgetPasswordResponse>(
        errorMessage: "Something went wrong. Please try again later.",
      );
    }
  }

  @override
  Future<BaseResponse<ForgetPasswordResponse>> confirmValidationCode(Map<String, dynamic> body) async{
    try {
      final response = await forgetPasswordApiClient.forgetPassword(body: body);

      return SuccessBaseResponse<ForgetPasswordResponse>(data: response);
    } catch (e) {
      if (e is DioException) {
        final data = e.response?.data;
        final messageFromApi = (data is Map<String, dynamic>)
            ? data['message']?.toString()
            : null;
        return ErrorBaseResponse<ForgetPasswordResponse>(
          errorMessage:
          messageFromApi ??
              e.message ??
              "Something went wrong. Please try again later.",
        );
      } else if (e is TimeoutException) {
        return ErrorBaseResponse<ForgetPasswordResponse>(
          errorMessage: "Request timed out. Please try again later.",
        );
      }
      return ErrorBaseResponse<ForgetPasswordResponse>(
        errorMessage: "Something went wrong. Please try again later.",
      );
    }
  }


}
