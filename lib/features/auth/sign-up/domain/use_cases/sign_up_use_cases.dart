import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

import '../models/user_entity.dart';
import '../repo/sign_up_repo_contract.dart';

@injectable
class SignUpUseCases {
  final SignUpRepoContract repo;

  SignUpUseCases(this.repo);

  Future<BaseResponse<UserEntity>> call({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
    required String gender,
  }) async {
    return await repo.signUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
      gender: gender,
    );
  }
}