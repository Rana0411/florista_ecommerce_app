import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/data/models/responses/forget_password_response.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/domain/repo/forget_password_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordUseCase {
  final ForgetPasswordRepoContract forgetPasswordRepo;

  ForgetPasswordUseCase({required this.forgetPasswordRepo});

  Future<BaseResponse<ForgetPasswordResponse>> call(
    Map<String, dynamic> body,
  ) async {

    return await forgetPasswordRepo.forgetPassword(body);
  }
}
