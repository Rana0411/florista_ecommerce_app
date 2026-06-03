import 'package:florista_ecommerce_app/core/api_constants/base_urls.dart';

abstract class ApiEndpoints {
  static const String _baseUrl = BaseUrls.flowerAppBaseURl;
  static const String getUserData = '$_baseUrl/auth/profile-data';
  static const String editProfile = '$_baseUrl/auth/editProfile';
  static const String uploadProfilePhoto = '$_baseUrl/auth/upload-photo';
  static const String changePassword = '$_baseUrl/auth/change-password';
}
