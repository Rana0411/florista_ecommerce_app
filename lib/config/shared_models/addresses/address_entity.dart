import 'package:florista_ecommerce_app/features/payment/data/models/shipping_address_request.dart';

class AddressEntity {
  final String id;
  final String label;
  final String plusCode;
  final String area;
  final String lat;
  final String long;
  final String phone;

  const AddressEntity({
    required this.id,
    required this.label,
    required this.plusCode,
    required this.area,
    required this.lat,
    required this.long,
    required this.phone,
  });

  String get shortLine => '$plusCode - $area';

  ShippingAddressDetails toShippingAddressDetails() => ShippingAddressDetails(
    street: plusCode,
    phone: phone,
    city: area,
    lat: lat,
    long: long,
  );
}
