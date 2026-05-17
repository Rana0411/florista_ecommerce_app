import 'package:florista_ecommerce_app/core/api_constants/base_urls.dart';

abstract class ApiEndpoints {
  static const String _baseUrl = BaseUrls.flowerAppBaseURl;
  static const String allOccasions = "$_baseUrl/occasions";
  static const String productsOfOccasion = "$_baseUrl/products";
}
