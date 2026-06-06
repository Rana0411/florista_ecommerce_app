import 'package:florista_ecommerce_app/core/api_constants/base_urls.dart';

abstract class ApiEndpoints {
  static const String _baseUrl = BaseUrls.flowerAppBaseURl;
  static const String getCategories = "$_baseUrl/categories";
  static const String getProducts = "$_baseUrl/products";
  static const String signUp = "$_baseUrl/auth/signup";
  static const String getBestSeller = "$_baseUrl/best-seller";
  static const String getProductdetails = "$_baseUrl/product-details";
}
