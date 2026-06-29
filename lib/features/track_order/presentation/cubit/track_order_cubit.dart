import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/orders/domain/entities/order_entity.dart';
import 'package:florista_ecommerce_app/features/orders/domain/use_cases/orders_use_cases.dart';
import 'package:florista_ecommerce_app/features/track_order/domain/entities/track_order_entities.dart';
import 'track_order_state.dart';


class TrackOrderCubit extends Cubit<TrackOrderState> {
  TrackOrderCubit(this._getUserOrders) : super(const TrackOrderState());

  final GetUserOrdersUseCase _getUserOrders;
  Timer? _pollingTimer;
  String? _orderId;

  Future<void> load(String orderId) async {
    _orderId = orderId;
    if (isClosed) return;
    emit(state.copyWith(isLoading: true, clearError: true));
    await _fetch();
    _startPolling();
  }

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      if (!state.isDelivered) _fetch(silent: true);
    });
  }

  Future<void> _fetch({bool silent = false}) async {
    if (isClosed || _orderId == null) return;
    if (!silent) emit(state.copyWith(isLoading: true, clearError: true));

    final response = await _getUserOrders();

    switch (response) {
      case SuccessBaseResponse():
        final order = response.data.firstWhere(
          (o) => o.id == _orderId,
          orElse: () => response.data.isNotEmpty
              ? response.data.first
              : _emptyOrder(),
        );
        if (!isClosed) {
          emit(state.copyWith(
            isLoading: false,
            order: order,
            driver: _buildDriver(order),
            timeline: _buildTimeline(order),
            estimatedArrival: _estimateArrival(order),
          ));
        }
      case ErrorBaseResponse():
        // Real API failed — show the error; no fake data so the user
        // always sees live driver info, never a hardcoded placeholder.
        if (!isClosed) {
          emit(state.copyWith(
            isLoading: false,
            errorMessage: response.getErrorMessage(),
          ));
        }
    }
  }

  // ── Driver info ──────────────────────────────────────────────────────────

  /// Builds a [DriverEntity] from the real driver fields on [order].
  /// Falls back gracefully if the Firestore data hasn't arrived yet.
  DriverEntity _buildDriver(OrderEntity order) {
    return DriverEntity(
      name: order.driverName ?? 'Waiting for driver…',
      phoneNumber: order.driverPhone ?? '',
      avatarAsset:
          order.driverAvatarAsset ?? 'assets/images/Delivery Boy.png',
    );
  }

  // ── Timeline ─────────────────────────────────────────────────────────────


  List<TrackTimelineEntry> _buildTimeline(OrderEntity order) {

    final int completedSteps;
    switch (order.driverStatus) {
      case null:
        completedSteps = 0;
      case DriverStatus.arrivedAtPickup:
        completedSteps = 1; // "Received your order"
      case DriverStatus.startDeliver:
        completedSteps = 2; // "Preparing your order"
      case DriverStatus.arrivedToUser:
        completedSteps = 3; // "Out for delivery"
      case DriverStatus.delivered:
        completedSteps = 4; // "Delivered"
    }


    final timestamps = [
      order.arrivedAtPickupAt,  // step 1: Received your order
      order.startDeliverAt,     // step 2: Preparing your order
      order.arrivedToUserAt,    // step 3: Out for delivery
      order.deliveredAt,        // step 4: Delivered
    ];

    final steps = TrackOrderStep.values;
    return List.generate(steps.length, (i) {
      final isDone = i < completedSteps;
      return TrackTimelineEntry(
        step: steps[i],

        timestamp: isDone ? timestamps[i] : null,
        isCompleted: isDone,
      );
    });
  }

  // ── Estimated arrival ────────────────────────────────────────────────────

  DateTime _estimateArrival(OrderEntity order) {
    // Use the real delivered timestamp if already done.
    if (order.deliveredAt != null) return order.deliveredAt!;
    // Otherwise estimate +1 hour from order creation.
    // Your teammates can replace this with a real ETA from Firestore later.
    return order.createdAt.add(const Duration(hours: 1));
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  OrderEntity _emptyOrder() => OrderEntity(
        id: _orderId ?? '',
        orderNumber: _orderId ?? '',
        items: const [],
        totalPrice: 0,
        status: OrderStatus.pending,
        createdAt: DateTime.now(),
      );

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }
}
