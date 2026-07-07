import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/payment/api/api_client/api_client.dart';
import 'package:florista_ecommerce_app/features/payment/data/data_sources/remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/payment/data/models/stripe_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteDataSourceContract)
class RemoteDataSourceImpl implements RemoteDataSourceContract {
  ApiClient apiClient;
  RemoteDataSourceImpl({required this.apiClient});
  @override
  Future<BaseResponse<StripeResponse?>> createCheckoutSession(
    Map<String, dynamic> request,
    String url,
  ) async {
    try {
      final response = await apiClient.createCheckoutSession(request, url);
      return SuccessBaseResponse(
        data: response ?? StripeResponse(message: '', checkoutUrl: ''),
      );
    } catch (e) {
      return ErrorBaseResponse(error: e.toString());
    }
    // Implementation for creating checkout session
  }
}
