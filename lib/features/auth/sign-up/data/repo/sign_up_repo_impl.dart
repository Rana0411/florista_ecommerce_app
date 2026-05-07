import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/user_entity.dart';
import '../../domain/repo/sign_up_repo_contract.dart';
import '../data_souurces/login_up_remote_data_source_contract.dart';

@Injectable(as: SignUpRepoContract)
class SignUpRepoImpl implements SignUpRepoContract {
  final SignUpRemoteDataSourceContract remoteDataSource;

  SignUpRepoImpl(this.remoteDataSource);

  @override
  Future<BaseResponse<UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
    required String rePassword,
    required String phone,

  }) async {
    final response = await remoteDataSource.signUp(
      name: name,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
    );

    switch (response) {
      case SuccessBaseResponse():
        return SuccessBaseResponse(
          data: response.data.toEntity(),
        );

      case ErrorBaseResponse():
        return ErrorBaseResponse(
          error: response.error,
          errorMessage: response.errorMessage,
        );
    }
  }
}