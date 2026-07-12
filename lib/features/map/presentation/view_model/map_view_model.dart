import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/base_state/base_state.dart';
import 'package:florista_ecommerce_app/config/launcher_service/launcher_service.dart';
import 'package:florista_ecommerce_app/config/map_service/location_service.dart';
import 'package:florista_ecommerce_app/features/map/data/models/map_path_model.dart';
import 'package:florista_ecommerce_app/features/map/domain/use_cases/get_route_points_use_case.dart';
import 'map_event.dart';
import 'map_state.dart';

@injectable
class MapCubit extends Cubit<MapState> {
  final GetRoutePointsUseCase _getRoutePointsUseCase;
  // Kept for DI compatibility (still registered via GetIt) — no longer
  // used to source the map's "driver" position, since that now comes
  // live from Firestore (see `_listenToDriverLocation` below).
  // ignore: unused_field
  final LocationService _locationService;
  final LauncherService _launcherService;

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
  _driverLocationSubscription;

  MapCubit({
    required GetRoutePointsUseCase getRoutePointsUseCase,
    required LocationService locationService,
    required LauncherService launcherService,
  }) : _launcherService = launcherService,
        _getRoutePointsUseCase = getRoutePointsUseCase,
        _locationService = locationService,
        super(const MapState());

  void onEvent(MapEvents event) {
    switch (event) {
      case GetRouteEvent():
        _getRouteAndStartTracking(event.endPoint, event.orderId);
      case CallUserEvent():
        _callUser(event.phone);
      case OpenChatEvent():
        _openChat(event.phone);
    }
  }

  Future<void> _getRouteAndStartTracking(LatLng end, String orderId) async {
    emit(state.copyWith(getRouteState: const BaseState(isLoading: true)));

    if (orderId.isEmpty) {
      emit(
        state.copyWith(
          getRouteState: const BaseState(
            isLoading: false,
            errorMessage: 'Missing order id — can\'t track the driver.',
          ),
        ),
      );
      return;
    }

    _listenToDriverLocation(orderId, end);
  }

  /// Streams `orders/{orderId}.driverLocation` from Firestore — the
  /// position the Tracking App writes every 5 seconds while delivering
  /// this order — and redraws the route/marker every time it changes.
  /// Firestore only pushes an update when the field actually changes, so
  /// this reacts in real time and is cheaper than polling on a timer.
  void _listenToDriverLocation(String orderId, LatLng end) {
    _driverLocationSubscription?.cancel();

    _driverLocationSubscription = FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .snapshots()
        .listen((snapshot) => _onDriverLocationSnapshot(snapshot, end));
  }

  Future<void> _onDriverLocationSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      LatLng end,
      ) async {
    if (isClosed) return;

    final data = snapshot.data();
    final rawLocation = data?['driverLocation'];

    if (rawLocation is! Map) {
      // Driver hasn't started sharing their location yet.
      emit(
        state.copyWith(
          getRouteState: const BaseState(
            isLoading: false,
            errorMessage: 'Waiting for the driver\'s live location…',
          ),
        ),
      );
      return;
    }

    final double? lat = _asDouble(rawLocation['lat']);
    final double? long = _asDouble(rawLocation['long'] ?? rawLocation['lng']);
    if (lat == null || long == null) return;

    final LatLng driverLocation = LatLng(lat, long);

    final String coords =
        '${driverLocation.longitude},${driverLocation.latitude};${end.longitude},${end.latitude}';
    final response = await _getRoutePointsUseCase(coordinates: coords);
    if (isClosed) return;

    List<LatLng> roadPoints = [driverLocation, end];

    switch (response) {
      case SuccessBaseResponse<List<MapPathModel>>():
        if (response.data.isNotEmpty) {
          final path = response.data.first;
          if (path.geometry?.coordinates != null) {
            roadPoints = path.geometry!.coordinates!.map((coord) {
              final double lat = (coord[1] as num).toDouble();
              final double lng = (coord[0] as num).toDouble();
              return LatLng(lat, lng);
            }).toList();
          }
        }

        emit(
          state.copyWith(
            getRouteState: BaseState(isLoading: false, data: roadPoints),
            currentDeliveryLocation: driverLocation,
          ),
        );
      case ErrorBaseResponse<List<MapPathModel>>():
      // Route service hiccup — still move the driver marker so the
      // live position stays accurate even if the road path doesn't.
        emit(state.copyWith(currentDeliveryLocation: driverLocation));
    }
  }

  double? _asDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  Future<void> _callUser(String phone) async {
    await _launcherService.openPhone(phone);
  }

  Future<void> _openChat(String phone) async {
    await _launcherService.openWhatsApp(phone);
  }

  @override
  Future<void> close() {
    _driverLocationSubscription?.cancel();
    return super.close();
  }
}
