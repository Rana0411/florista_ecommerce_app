import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/auth/login/domain/entity/login_entity.dart';
import 'package:florista_ecommerce_app/features/auth/login/domain/repo/login_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final LoginRepo _loginRepo;

  const LoginUseCase(this._loginRepo);

  Future<BaseResponse<LoginEntity>> call({
    required String email,
    required String password,
    required bool rememberMe,
  }) =>
      _loginRepo.login(email: email, password: password, rememberMe: rememberMe);
}
