abstract class AppConstants {
  static const String regExpValidateName = r'^[a-zA-Z]+$';
  static const String regExpValidatePhone = r'^\+?20?01[0125][0-9]{8}$';
  static const String regExpValidatePassword =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$';
  static const String regExpValidateEmail =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const imagePlaceholder = "assets/images/image_placeholder.png";
  static const List<String> mapTileSubdomains = ['a', 'b', 'c', 'd'];
  static const String userAgentPackageName = 'com.yourcompany.tracking_app';
}
