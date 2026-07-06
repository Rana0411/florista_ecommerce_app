import 'dart:async';

import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/address/add_address/api/api_client/add_address_api_client.dart';
import 'package:florista_ecommerce_app/features/address/add_address/data/data_sources/add_address_remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/address/add_address/data/models/responsess/add_address_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddAddressRemoteDataSourceContract)
class AddAddressRemoteDataSourceImpl
    implements AddAddressRemoteDataSourceContract {
  final AddAddressApiClient addAddressApiClient;

  AddAddressRemoteDataSourceImpl({required this.addAddressApiClient});

  @override
  Future<BaseResponse<AddAddressResponse>> addAddress(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await addAddressApiClient.addAddress(body);
      return SuccessBaseResponse<AddAddressResponse>(data: response);
    } catch (e) {
      if (e is DioException) {
        final data = e.response?.data;
        final messageFromApi = (data is Map<String, dynamic>)
            ? data['message']?.toString()
            : null;
        return ErrorBaseResponse<AddAddressResponse>(
          errorMessage:
              messageFromApi ??
              e.message ??
              "Something went wrong. Please try again later.",
        );
      } else if (e is TimeoutException) {
        return ErrorBaseResponse<AddAddressResponse>(
          errorMessage: "Request timed out. Please try again later.",
        );
      }
      return ErrorBaseResponse<AddAddressResponse>(
        errorMessage: "Something went wrong. Please try again later.",
      );
    }
  }

  @override
  Future<BaseResponse<AddAddressResponse>> getAddresses() async {
    try {
      final response = await addAddressApiClient.getAddresses();
      return SuccessBaseResponse<AddAddressResponse>(data: response);
    } catch (e) {
      if (e is DioException) {
        final data = e.response?.data;
        final messageFromApi = (data is Map<String, dynamic>)
            ? data['message']?.toString()
            : null;
        return ErrorBaseResponse<AddAddressResponse>(
          errorMessage:
              messageFromApi ??
              e.message ??
              "Something went wrong. Please try again later.",
        );
      } else if (e is TimeoutException) {
        return ErrorBaseResponse<AddAddressResponse>(
          errorMessage: "Request timed out. Please try again later.",
        );
      }
      return ErrorBaseResponse<AddAddressResponse>(
        errorMessage: "Something went wrong. Please try again later.",
      );
    }
  }
}
