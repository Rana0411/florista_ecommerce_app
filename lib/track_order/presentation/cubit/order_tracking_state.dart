
import 'package:equatable/equatable.dart';
import '../../domain/entities/order_tracking_entity.dart';

class TrackOrderState extends Equatable {
  final bool isLoading;
  final OrderTrackingEntity? tracking;
  final String? errorMessage;

  const TrackOrderState({
    this.isLoading = false,
    this.tracking,
    this.errorMessage,
  });

  TrackOrderState copyWith({
    bool? isLoading,
    OrderTrackingEntity? tracking,
    String? errorMessage,
  }) {
    return TrackOrderState(
      isLoading: isLoading ?? this.isLoading,
      tracking: tracking ?? this.tracking,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, tracking, errorMessage];
}