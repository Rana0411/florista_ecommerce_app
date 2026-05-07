
import 'package:florista_ecommerce_app/features/auth/login/data/model/login_request_model.dart';
import 'package:florista_ecommerce_app/features/auth/login/data/model/login_response_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../login_api/api_cilent.dart';

abstract class LoginRemoteDataSource {
  Future<BaseResponse<LoginResponseModel>> login(LoginRequestModel request);
}

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiClient _apiClient;

  const LoginRemoteDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<LoginResponseModel>> login(
      LoginRequestModel request,
      ) async {
    try {
      final response = await _apiClient.login(request);
      return SuccessBaseResponse(data: response);
    } catch (e) {
      return ErrorBaseResponse(
        error: e,
        errorMessage: ErrorBaseResponse(error: e).getErrorMessage(),
      );
    }
  }
}