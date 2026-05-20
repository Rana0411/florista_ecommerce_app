import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/change_password/data/data_sources/change_password_remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/change_password/data/models/change_password_request.dart';
import 'package:florista_ecommerce_app/features/change_password/data/models/change_password_response.dart';
import 'package:florista_ecommerce_app/features/change_password/domain/repo/change_password_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordRepoContract)
class ChangePasswordRepoImpl implements ChangePasswordRepoContract {
  final ChangePasswordRemoteDataSourceContract
  changePasswordRemoteDataSourceContract;

  ChangePasswordRepoImpl({
    required this.changePasswordRemoteDataSourceContract,
  });
  @override
  Future<BaseResponse<ChangePasswordResponse>> changePassword({
    required ChangePasswordRequest passwords,
  }) async {
    final response = await changePasswordRemoteDataSourceContract
        .changePassword(passwords: passwords);

    //* i made this switch cuz i want to extraxt the error message
    switch (response) {
      case SuccessBaseResponse<ChangePasswordResponse>():
        return SuccessBaseResponse<ChangePasswordResponse>(data: response.data);
      case ErrorBaseResponse<ChangePasswordResponse>():
        return ErrorBaseResponse<ChangePasswordResponse>(
          errorMessage: response.getErrorMessage(),
        );
    }
  }
}
