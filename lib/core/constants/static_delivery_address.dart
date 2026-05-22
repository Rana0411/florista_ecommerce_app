/// Static delivery location for the cart screen (Sheikh Zayed City, Egypt).
abstract class StaticDeliveryAddress {
  static const String label = 'Home';

  /// Google Plus Code shown in the design mockup.
  static const String plusCode = '2XVP+XC';

  static const String area = 'Sheikh Zayed City';

  static const String governorate = 'Giza Governorate';

  static const String country = 'Egypt';

  /// One-line summary for the cart header.
  static const String shortLine = '$plusCode · $area';

  /// Full postal-style address.
  static const String fullAddress =
      'Building 12, District 7, $area, $governorate, $country';

  /// Coordinates for Sheikh Zayed City (6th of October area).
  static const double latitude = 30.028056;

  static const double longitude = 30.969444;

  static const String mapsSearchQuery = '$plusCode $area $governorate $country';
}
