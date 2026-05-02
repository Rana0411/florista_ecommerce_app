import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/core/constants/api_endpoints.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @singleton
  Dio get dio => Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      sendTimeout: const Duration(seconds: 20),
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );
}
