import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/handler/secure_storage_handler.dart';
import 'package:florista_ecommerce_app/config/secure_storage/secure_storage_service.dart';
import 'package:florista_ecommerce_app/core/app_keys/secure_storage_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  final SecureStorageService secureStorage;

  AuthInterceptor(this.secureStorage);

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final response = await secureStorage.read(key: SecureStorageKeys.token);

    if (kDebugMode) {
      if (response is ErrorBaseResponse) {
        debugPrint('[AuthInterceptor] ⚠️ Token read failed: ${(response as ErrorBaseResponse).errorMessage}');
      }
    }

    final token = SecureStorageHandler.handle<String>(response);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      if (kDebugMode) {
        debugPrint('[AuthInterceptor] ✅ Token attached to request');
      }
    } else {
      if (kDebugMode) {
        debugPrint('[AuthInterceptor] ⚠️ No token found — request will be unauthenticated');
      }
    }

    handler.next(options);
  }
}
