import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/payment/data/models/stripe_response.dart';

abstract interface class RemoteDataSourceContract {
  Future<BaseResponse<StripeResponse?>> createCheckoutSession(
    Map<String, dynamic> request,
    String url,
  );
}
