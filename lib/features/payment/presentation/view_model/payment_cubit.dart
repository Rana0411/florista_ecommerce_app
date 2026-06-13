import 'package:equatable/equatable.dart';
import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/base_state/base_state.dart';
import 'package:florista_ecommerce_app/config/handler/response_to_state_mapper.dart';
import 'package:florista_ecommerce_app/config/shared_models/addresses/address_entity.dart';
import 'package:florista_ecommerce_app/features/payment/data/models/shipping_address_request.dart';
import 'package:florista_ecommerce_app/features/payment/data/models/stripe_response.dart';
import 'package:florista_ecommerce_app/features/payment/domain/use_cases/create_checkout_session_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'payment_states.dart';

@injectable
class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({required this.createCheckoutSessionUseCase})
    : super(PaymentState(checkoutState: BaseState()));

  final CreateCheckoutSessionUseCase createCheckoutSessionUseCase;

  Future<void> checkout({
    required AddressEntity address,
    required String paymentMethod,
    String redirectUrl = 'http://localhost:3000',
  }) async {
    emit(
      state.copyWith(
        checkoutState: state.checkoutState.copyWith(isLoading: true),
      ),
    );

    final shippingRequest = ShippingAddressRequest(
      shippingAddress: address.toShippingAddressDetails(),
    );

    final response = await createCheckoutSessionUseCase(
      shippingRequest.toJson(),
      redirectUrl,
    );

    switch (response) {
      case SuccessBaseResponse<StripeResponse?>():
        emit(
          state.copyWith(
            checkoutState: ResponseToStateMapper.handle<StripeResponse?>(
              response,
            ),
          ),
        );
      case ErrorBaseResponse<StripeResponse?>():
        emit(
          state.copyWith(
            checkoutState: BaseState(
              data: null,
              isLoading: false,
              errorMessage: response.getErrorMessage(),
            ),
          ),
        );
    }
  }

  void reset() => emit(PaymentState(checkoutState: BaseState()));
}
