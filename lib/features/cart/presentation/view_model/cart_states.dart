part of 'cart_cubit.dart';

class CartState extends Equatable {
  final BaseState<CartResponseEntity> cartState;
  final String? busyRowId;
  final String? message;

  const CartState({
    required this.cartState,
    this.busyRowId,
    this.message,
  });

  bool get isEmpty => cartState.data?.cart.cartItems.isEmpty ?? true;

  CartState copyWith({
    BaseState<CartResponseEntity>? cartState,
    String? busyRowId,
    bool clearBusyRowId = false,
    String? message,
    bool clearMessage = false,
  }) {
    return CartState(
      cartState: cartState ?? this.cartState,
      busyRowId: clearBusyRowId ? null : (busyRowId ?? this.busyRowId),
      message: clearMessage ? null : (message ?? this.message),
    );
  }

  @override
  List<Object?> get props => [cartState, busyRowId, message];
}
