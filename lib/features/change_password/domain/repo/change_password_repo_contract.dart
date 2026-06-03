import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/change_password/data/models/change_password_request.dart';
import 'package:florista_ecommerce_app/features/change_password/data/models/change_password_response.dart';

abstract interface class ChangePasswordRepoContract {
  Future<BaseResponse<ChangePasswordResponse>> changePassword({
    required ChangePasswordRequest passwords,
  });
}
