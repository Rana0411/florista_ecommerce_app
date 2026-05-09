import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/data/data_source/forget_password_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/data/models/responses/forget_password_response.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/domain/repo/forget_password_repo_contract.dart';

class ForgetPasswordRepoImpl implements ForgetPasswordRepoContract {
  final ForgetPasswordDataSourceContract forgetPasswordDataSource;

  ForgetPasswordRepoImpl({required this.forgetPasswordDataSource});

  @override
  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(
    Map<String, dynamic> body,
  ) async {
    final response = await forgetPasswordDataSource.forgetPassword(body);
    switch (response) {
      case SuccessBaseResponse():
        return SuccessBaseResponse(data: response.data);
      case ErrorBaseResponse():
        return ErrorBaseResponse(errorMessage: response.errorMessage);
    }
  }
}
