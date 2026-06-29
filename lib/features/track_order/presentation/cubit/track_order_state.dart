import 'package:equatable/equatable.dart';

import 'package:florista_ecommerce_app/features/orders/domain/entities/order_entity.dart';
import 'package:florista_ecommerce_app/features/track_order/domain/entities/track_order_entities.dart';

class TrackOrderState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final OrderEntity? order;


  final DriverEntity driver;
  final List<TrackTimelineEntry> timeline;
  final DateTime? estimatedArrival;

  const TrackOrderState({
    this.isLoading = false,
    this.errorMessage,
    this.order,
    this.driver = const DriverEntity(
      name: 'Waiting for driver…',
      phoneNumber: '',
      avatarAsset: 'assets/images/Delivery Boy.png',
    ),
    this.timeline = const [],
    this.estimatedArrival,
  });

  bool get isDelivered =>
      timeline.isNotEmpty &&
      timeline.last.step == TrackOrderStep.delivered &&
      timeline.last.isCompleted;

  TrackOrderState copyWith({
    bool? isLoading,
    String? errorMessage,
    OrderEntity? order,
    DriverEntity? driver,
    List<TrackTimelineEntry>? timeline,
    DateTime? estimatedArrival,
    bool clearError = false,
  }) {
    return TrackOrderState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      order: order ?? this.order,
      driver: driver ?? this.driver,
      timeline: timeline ?? this.timeline,
      estimatedArrival: estimatedArrival ?? this.estimatedArrival,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        order,
        driver,
        timeline,
        estimatedArrival,
      ];
}
