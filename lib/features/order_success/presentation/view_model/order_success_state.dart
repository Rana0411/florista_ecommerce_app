import 'package:equatable/equatable.dart';

import '../../domain/entities/order_success_entity.dart';

sealed class OrderSuccessState extends Equatable {
  const OrderSuccessState();

  @override
  List<Object?> get props => [];
}

class OrderSuccessInitial extends OrderSuccessState {
  const OrderSuccessInitial();
}

class OrderSuccessLoading extends OrderSuccessState {
  const OrderSuccessLoading();
}

class OrderSuccessSuccess extends OrderSuccessState {
  const OrderSuccessSuccess(this.order);

  final OrderSuccessEntity order;

  @override
  List<Object?> get props => [order];
}

class OrderSuccessFailure extends OrderSuccessState {
  const OrderSuccessFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}