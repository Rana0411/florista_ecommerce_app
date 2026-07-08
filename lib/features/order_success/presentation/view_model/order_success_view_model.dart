import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/get_order_success_details_use_case.dart';
import 'order_success_state.dart';

@injectable
class OrderSuccessViewModel extends Cubit<OrderSuccessState> {
  OrderSuccessViewModel(this._getOrderSuccessDetailsUseCase)
      : super(const OrderSuccessInitial());

  final GetOrderSuccessDetailsUseCase _getOrderSuccessDetailsUseCase;

  Future<void> getOrderSuccessDetails(String? orderId) async {
    if (orderId == null || orderId.isEmpty) return;

    emit(const OrderSuccessLoading());

    try {
      final order = await _getOrderSuccessDetailsUseCase(orderId);
      emit(OrderSuccessSuccess(order));
    } catch (_) {
      emit(const OrderSuccessFailure('Unable to load order details'));
    }
  }
}