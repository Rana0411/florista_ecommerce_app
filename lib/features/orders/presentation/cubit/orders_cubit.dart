import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import '../../domain/use_cases/orders_use_cases.dart';
import 'orders_state.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit({
    required GetUserOrdersUseCase getUserOrders,
    required CheckoutSessionUseCase checkoutSession,
    required CreateCashOrderUseCase createCashOrder,
  })  : _getUserOrders = getUserOrders,
        _checkoutSession = checkoutSession,
        _createCashOrder = createCashOrder,
        super(const OrdersState());

  final GetUserOrdersUseCase _getUserOrders;
  final CheckoutSessionUseCase _checkoutSession;
  final CreateCashOrderUseCase _createCashOrder;

  Future<void> loadOrders() async {
    if (isClosed) return;
    emit(state.copyWith(isLoading: true, clearError: true));

    final response = await _getUserOrders();

    switch (response) {
      case SuccessBaseResponse():
        final all = response.data;
        final active = all.where((o) => o.isActive).toList();
        final completed = all.where((o) => o.isCompleted).toList();
        if (!isClosed) {
          emit(state.copyWith(
            isLoading: false,
            activeOrders: active,
            completedOrders: completed,
          ));
        }
      case ErrorBaseResponse():
        if (!isClosed) {
          emit(state.copyWith(
            isLoading: false,
            errorMessage: response.getErrorMessage(),
          ));
        }
    }
  }

  Future<void> checkout(String cartId, String shippingAddress) async {
    if (isClosed) return;
    emit(state.copyWith(isCheckingOut: true, clearError: true));

    final response = await _checkoutSession(cartId, shippingAddress);

    switch (response) {
      case SuccessBaseResponse():
        if (!isClosed) {
          emit(state.copyWith(
            isCheckingOut: false,
            checkoutUrl: response.data,
            checkoutSuccess: true,
          ));
        }
      case ErrorBaseResponse():
        if (!isClosed) {
          emit(state.copyWith(
            isCheckingOut: false,
            errorMessage: response.getErrorMessage(),
          ));
        }
    }
  }

  Future<void> createCashOrder(String cartId, String shippingAddress) async {
    if (isClosed) return;
    emit(state.copyWith(isCheckingOut: true, clearError: true));

    final response = await _createCashOrder(cartId, shippingAddress);

    switch (response) {
      case SuccessBaseResponse():
        await loadOrders();
      case ErrorBaseResponse():
        if (!isClosed) {
          emit(state.copyWith(
            isCheckingOut: false,
            errorMessage: response.getErrorMessage(),
          ));
        }
    }
  }
}
