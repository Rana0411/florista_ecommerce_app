import 'package:florista_ecommerce_app/core/api_constants/base_urls.dart';

abstract class ApiEndpoints {
  static const String _baseUrl = BaseUrls.flowerAppBaseURl;
  static const String getCategories = "$_baseUrl/categories";
  static const String getProducts = "$_baseUrl/products";
  static const String signUp = "$_baseUrl/auth/signup";
  static const String getBestSeller = "$_baseUrl/best-seller";
  static const String forgetPassword = '$_baseUrl/auth/forgotPassword';
  static const String verifyResetCode = '$_baseUrl/auth/verifyResetCode';
  static const String resetPassword = '$_baseUrl/auth/resetPassword';


  static const String categories = '$_baseUrl/categories';
  static const String bestSeller = '$_baseUrl/best-seller';
  static const String occasions = '$_baseUrl/occasions';
  static const String addresses = '$_baseUrl/addresses';
  static const String getUserData = '$_baseUrl/auth/profile-data';
  static const String editProfile = '$_baseUrl/auth/editProfile';
  static const String uploadProfilePhoto = '$_baseUrl/auth/upload-photo';
  static const String changePassword = '$_baseUrl/auth/change-password';
}
