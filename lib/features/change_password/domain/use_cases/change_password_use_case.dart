import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/change_password/data/models/change_password_request.dart';
import 'package:florista_ecommerce_app/features/change_password/data/models/change_password_response.dart';
import 'package:florista_ecommerce_app/features/change_password/domain/repo/change_password_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {
  final ChangePasswordRepoContract changePasswordRepoContract;

  ChangePasswordUseCase({required this.changePasswordRepoContract});

  Future<BaseResponse<ChangePasswordResponse>> call({
    required ChangePasswordRequest passwords,
  }) {
    return changePasswordRepoContract.changePassword(passwords: passwords);
  }
}
