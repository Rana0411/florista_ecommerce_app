import 'package:florista_ecommerce_app/core/api_constants/base_urls.dart';

abstract class ApiEndpoints {
  static const String _baseUrl = BaseUrls.flowerAppBaseURl;
  static const String categories = '$_baseUrl/categories';
  static const String bestSeller = '$_baseUrl/best-seller';
  static const String occasions = '$_baseUrl/occasions';
  static const String addresses = '$_baseUrl/addresses';
}
