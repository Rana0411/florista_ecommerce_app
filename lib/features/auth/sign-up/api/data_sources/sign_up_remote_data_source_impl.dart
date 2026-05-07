import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';
import '../../data/data_souurces/login_up_remote_data_source_contract.dart';
import '../../data/models/sign_up_dto.dart';
import '../sign_up_api_client/sign_up_api_client.dart';

@Injectable(as: SignUpRemoteDataSourceContract)
class SignUpRemoteDataSourceImpl
    implements SignUpRemoteDataSourceContract {
  final SignUpApiClient apiClient;

  SignUpRemoteDataSourceImpl(this.apiClient);


  @override
  Future<BaseResponse<SignUpDto>> signUp({
    required String name,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    try {
      final response = await apiClient.signUp(
        name: name,
        email: email,
        password: password,
        rePassword: rePassword,
        phone: phone,
      );

      return SuccessBaseResponse(data: response);
    } on DioException catch (e) {
      return ErrorBaseResponse(error: e);
    } catch (e) {
      return ErrorBaseResponse(error: e);
    }
  }
}