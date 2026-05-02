import 'package:florista_ecommerce_app/config/base_response/base_response.dart';

class SecureStorageHandler<T> {
  final T? data;
  final String? errorMessage;
  final bool isSuccess;

  SecureStorageHandler({this.data, this.errorMessage, required this.isSuccess});

  static SecureStorageHandler<T> handle<T>(BaseResponse<T> response) {
    if (response is SuccessBaseResponse<T>) {
      return SecureStorageHandler<T>(data: response.data, isSuccess: true);
    } else if (response is ErrorBaseResponse<T>) {
      return SecureStorageHandler<T>(
        errorMessage: response.errorMessage,
        isSuccess: false,
      );
    } else {
      return SecureStorageHandler<T>(
        errorMessage: 'Unknown error',
        isSuccess: false,
      );
    }
  }
}
