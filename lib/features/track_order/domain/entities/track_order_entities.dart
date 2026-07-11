import 'package:equatable/equatable.dart';


enum TrackOrderStep { received, preparing, outForDelivery, delivered }

extension TrackOrderStepX on TrackOrderStep {
  String get label {
    switch (this) {
      case TrackOrderStep.received:
        return 'Received your order';
      case TrackOrderStep.preparing:
        return 'Preparing your order';
      case TrackOrderStep.outForDelivery:
        return 'Out for delivery';
      case TrackOrderStep.delivered:
        return 'Delivered';
    }
  }
}

class TrackTimelineEntry extends Equatable {
  final TrackOrderStep step;


  final DateTime? timestamp;
  final bool isCompleted;

  const TrackTimelineEntry({
    required this.step,
    required this.timestamp,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [step, timestamp, isCompleted];
}

/// Delivery destination for the order, streamed live from the Firestore
/// tracking document (`orders/{orderId}.shippingAddress`). Same field
/// shape (`street`, `phone`, `city`, `lat`, `long` as strings) the app
/// already sends to the backend when the order is placed
/// (see ShippingAddressDetails / AddAddressEntity), so the Tracking App
/// is expected to mirror it back here.
class TrackOrderShippingAddress extends Equatable {
  final String street;
  final String city;
  final String phone;
  final double? latitude;
  final double? longitude;

  const TrackOrderShippingAddress({
    required this.street,
    required this.city,
    required this.phone,
    required this.latitude,
    required this.longitude,
  });

  const TrackOrderShippingAddress.empty()
      : street = '',
        city = '',
        phone = '',
        latitude = null,
        longitude = null;

  /// Whether we have real coordinates we can hand to a maps app.
  bool get hasCoordinates => latitude != null && longitude != null;

  @override
  List<Object?> get props => [street, city, phone, latitude, longitude];
}

class DriverEntity extends Equatable {
  final String name;
  final String phoneNumber;
  final String avatarAsset;

  const DriverEntity({
    required this.name,
    required this.phoneNumber,
    required this.avatarAsset,
  });

  @override
  List<Object?> get props => [name, phoneNumber, avatarAsset];
}
