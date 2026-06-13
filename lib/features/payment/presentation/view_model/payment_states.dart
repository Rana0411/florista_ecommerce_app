// lib/features/payment/presentation/view_model/payment_states.dart
part of 'payment_cubit.dart';

class PaymentState extends Equatable {
  final BaseState<StripeResponse?> checkoutState;

  const PaymentState({required this.checkoutState});

  PaymentState copyWith({BaseState<StripeResponse?>? checkoutState}) {
    return PaymentState(checkoutState: checkoutState ?? this.checkoutState);
  }

  @override
  List<Object?> get props => [checkoutState];
}
