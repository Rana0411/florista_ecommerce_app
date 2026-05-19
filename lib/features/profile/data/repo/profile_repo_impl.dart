import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/shared_models/user_data/user_data_response.dart';
import 'package:florista_ecommerce_app/core/entities/user_data_entity.dart';
import 'package:florista_ecommerce_app/features/profile/data/data_sources/profile_remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/profile/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepoContract)
class ProfileRepoImpl implements ProfileRepoContract {
  final ProfileRemoteDataSourceContract profileRemoteDataSourceContract;

  ProfileRepoImpl({required this.profileRemoteDataSourceContract});
  @override
  Future<BaseResponse<UserDataEntity>> getUserData() async {
    final response = await profileRemoteDataSourceContract.getUserData();
    switch (response) {
      case SuccessBaseResponse<UserDataReponse>():
        return SuccessBaseResponse<UserDataEntity>(
          data: response.data.user!.toDomain(),
        );
      case ErrorBaseResponse<UserDataReponse>():
        return ErrorBaseResponse<UserDataEntity>(
          errorMessage: response.getErrorMessage(),
        );
    }
  }
}
