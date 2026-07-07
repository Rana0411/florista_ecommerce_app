import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/payment/data/models/stripe_response.dart';
import 'package:florista_ecommerce_app/features/payment/domain/repo/repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateCheckoutSessionUseCase {
  final RepoContract repo;

  CreateCheckoutSessionUseCase({required this.repo});

  Future<BaseResponse<StripeResponse?>> call(
    Map<String, dynamic> request,
    String url,
  ) {
    return repo.createCheckoutSession(request, url);
  }
}
