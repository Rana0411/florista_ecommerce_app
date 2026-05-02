import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<BaseResponse<String>> write({
    required String key,
    required String value,
  }) async {
    try {
      await _storage.write(key: key, value: value);
      return SuccessBaseResponse(data: key);
    } catch (e) {
      return ErrorBaseResponse(errorMessage: "$e");
    }
  }

  static Future<BaseResponse<String>> read({required String key}) async {
    try {
      final value = await _storage.read(key: key);

      if (value == null) {
        return ErrorBaseResponse(errorMessage: 'No value found for key: $key');
      }

      return SuccessBaseResponse(data: value);
    } catch (e) {
      return ErrorBaseResponse(errorMessage: "$e");
    }
  }

  static Future<BaseResponse<bool>> delete({required String key}) async {
    try {
      await _storage.delete(key: key);
      return SuccessBaseResponse(data: true);
    } catch (e) {
      return ErrorBaseResponse(errorMessage: "$e");
    }
  }

  static Future<BaseResponse<bool>> deleteAll() async {
    try {
      await _storage.deleteAll();
      return SuccessBaseResponse(data: true);
    } catch (e) {
      return ErrorBaseResponse(errorMessage: "$e");
    }
  }
}
