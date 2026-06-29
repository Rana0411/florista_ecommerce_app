import 'dart:async';
import 'package:florista_ecommerce_app/track_order/domain/usecase/order_tracking_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'order_tracking_state.dart' show TrackOrderState;
import 'package:florista_ecommerce_app/generated/l10n.dart';

@injectable
class TrackOrderCubit extends Cubit<TrackOrderState> {
  final WatchOrderTrackingUseCase watchOrderTrackingUseCase;
  StreamSubscription? _subscription;

  @factoryMethod
  TrackOrderCubit(this.watchOrderTrackingUseCase) : super(const TrackOrderState());

  void loadTracking(String orderId) {
    emit(state.copyWith(isLoading: true));
    _subscription?.cancel();
    _subscription = watchOrderTrackingUseCase(orderId).listen(
          (tracking) {
        emit(state.copyWith(isLoading: false, tracking: tracking));
      },
      onError: (_) {
        emit(state.copyWith(isLoading: false, errorMessage: S.current.somethineWentWrong));
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}