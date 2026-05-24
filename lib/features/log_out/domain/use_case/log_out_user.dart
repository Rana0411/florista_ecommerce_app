import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/log_out/domain/repo/repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogOutUserUseCase {
  final LogOutRepoContract _repo;

  LogOutUserUseCase(this._repo);

  Future<BaseResponse<String>> call() async {
    return await _repo.logOut();
  }
}
