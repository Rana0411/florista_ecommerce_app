import 'package:equatable/equatable.dart';
import '../../domain/entities/order_entity.dart';

class OrdersState extends Equatable {
  final bool isLoading;
  final bool isCheckingOut;
  final List<OrderEntity> activeOrders;
  final List<OrderEntity> completedOrders;
  final String? errorMessage;
  final String? checkoutUrl;
  final bool checkoutSuccess;

  const OrdersState({
    this.isLoading = false,
    this.isCheckingOut = false,
    this.activeOrders = const [],
    this.completedOrders = const [],
    this.errorMessage,
    this.checkoutUrl,
    this.checkoutSuccess = false,
  });

  OrdersState copyWith({
    bool? isLoading,
    bool? isCheckingOut,
    List<OrderEntity>? activeOrders,
    List<OrderEntity>? completedOrders,
    String? errorMessage,
    String? checkoutUrl,
    bool? checkoutSuccess,
    bool clearError = false,
  }) {
    return OrdersState(
      isLoading: isLoading ?? this.isLoading,
      isCheckingOut: isCheckingOut ?? this.isCheckingOut,
      activeOrders: activeOrders ?? this.activeOrders,
      completedOrders: completedOrders ?? this.completedOrders,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      checkoutUrl: checkoutUrl ?? this.checkoutUrl,
      checkoutSuccess: checkoutSuccess ?? this.checkoutSuccess,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isCheckingOut,
        activeOrders,
        completedOrders,
        errorMessage,
        checkoutUrl,
        checkoutSuccess,
      ];
}
