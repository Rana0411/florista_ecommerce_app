import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/payment/data/data_sources/remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/payment/data/models/stripe_response.dart';
import 'package:florista_ecommerce_app/features/payment/domain/repo/repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RepoContract)
class RepoImpl implements RepoContract {
  final RemoteDataSourceContract remoteDataSource;

  RepoImpl({required this.remoteDataSource});

  @override
  Future<BaseResponse<StripeResponse?>> createCheckoutSession(
    Map<String, dynamic> request,
    String url,
  ) async {
    final response = await remoteDataSource.createCheckoutSession(request, url);

    switch (response) {
      case SuccessBaseResponse<StripeResponse?>():
        return SuccessBaseResponse(data: response.data);
      case ErrorBaseResponse<StripeResponse?>():
        return ErrorBaseResponse(
          errorMessage: response.errorMessage ?? 'Unknown error',
        );
    }
  }
}
