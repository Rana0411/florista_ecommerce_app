import 'package:florista_ecommerce_app/core/api_constants/base_urls.dart';

abstract class ApiEndpoints {
  static const String _baseUrl = BaseUrls.flowerAppBaseURl;
  static const String cartOfLoggedUSer = "$_baseUrl/cart";
  static const String checkoutSession = "$_baseUrl//orders/checkout";
}
