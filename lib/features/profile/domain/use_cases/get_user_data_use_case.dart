import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/user_data/user_request_dto.dart';
import 'package:florista_ecommerce_app/features/profile/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserDataUseCase {
  final ProfileRepoContract profileRepoContract;

  GetUserDataUseCase({required this.profileRepoContract});
  Future<BaseResponse<UserRequestDto>> call() async {
    return profileRepoContract.getUserData();
  }
}
