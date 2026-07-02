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
