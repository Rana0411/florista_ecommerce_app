// lib/features/payment/domain/repo/repo_contract.dart
import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/payment/data/models/stripe_response.dart';

abstract interface class RepoContract {
  Future<BaseResponse<StripeResponse?>> createCheckoutSession(
    Map<String, dynamic> request,
    String url,
  );
}
