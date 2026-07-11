import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/orders/domain/entities/order_entity.dart';
import 'package:florista_ecommerce_app/features/orders/domain/use_cases/orders_use_cases.dart';
import 'package:florista_ecommerce_app/features/track_order/data/data_sources/track_order_remote_data_source.dart';
import 'package:florista_ecommerce_app/features/track_order/data/models/order_tracking_snapshot.dart';
import 'package:florista_ecommerce_app/features/track_order/domain/entities/track_order_entities.dart';
import 'track_order_state.dart';

class TrackOrderCubit extends Cubit<TrackOrderState> {
  TrackOrderCubit(this._getUserOrders, this._trackingDataSource)
      : super(const TrackOrderState());

  final GetUserOrdersUseCase _getUserOrders;
  final TrackOrderRemoteDataSource _trackingDataSource;

  StreamSubscription<OrderTrackingSnapshot>? _trackingSubscription;
  String? _orderId;
  OrderEntity? _baseOrder;

  Future<void> load(String orderId) async {
    _orderId = orderId;
    if (isClosed) return;
    emit(state.copyWith(isLoading: true, clearError: true));
    await _fetchBaseOrder();
    _listenToTracking(orderId);
  }

  /// One-time REST fetch for the order's static data (items, price,
  /// order number, createdAt). This never repeats — live driver/timeline
  /// updates come from the Firestore stream in [_listenToTracking].
  Future<void> _fetchBaseOrder() async {
    if (isClosed || _orderId == null) return;

    final response = await _getUserOrders();

    switch (response) {
      case SuccessBaseResponse():
        final order = response.data.firstWhere(
          (o) => o.id == _orderId,
          orElse: () => response.data.isNotEmpty
              ? response.data.first
              : _emptyOrder(),
        );
        _baseOrder = order;
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

  /// Subscribes to the single order's live tracking document. Firestore
  /// only pushes an update when the document actually changes, so this
  /// is real-time and far cheaper than the previous 15s full-list poll.
  void _listenToTracking(String orderId) {
    _trackingSubscription?.cancel();
    _trackingSubscription = _trackingDataSource
        .watchOrderTracking(orderId)
        .listen(_onTrackingSnapshot);
  }

  void _onTrackingSnapshot(OrderTrackingSnapshot snapshot) {
    if (isClosed) return;
    final base = _baseOrder;
    if (base == null) return;

    final mergedOrder = OrderEntity(
      id: base.id,
      orderNumber: base.orderNumber,
      items: base.items,
      totalPrice: base.totalPrice,
      status: base.status,
      deliveredAt: snapshot.deliveredAt ?? base.deliveredAt,
      createdAt: base.createdAt,
      driverStatus: snapshot.driverStatus,
      arrivedAtPickupAt: snapshot.arrivedAtPickupAt,
      startDeliverAt: snapshot.startDeliverAt,
      arrivedToUserAt: snapshot.arrivedToUserAt,
      driverName: snapshot.driverName,
      driverPhone: snapshot.driverPhone,
      driverAvatarAsset: snapshot.driverAvatarAsset,
    );

    emit(state.copyWith(
      isLoading: false,
      order: mergedOrder,
      driver: _buildDriver(mergedOrder),
      timeline: _buildTimeline(mergedOrder),
      estimatedArrival: _estimateArrival(mergedOrder),
      shippingAddress: snapshot.shippingAddress,
    ));
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
      order.arrivedAtPickupAt, // step 1: Received your order
      order.startDeliverAt, // step 2: Preparing your order
      order.arrivedToUserAt, // step 3: Out for delivery
      order.deliveredAt, // step 4: Delivered
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
    _trackingSubscription?.cancel();
    return super.close();
  }
}
