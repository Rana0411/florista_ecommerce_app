import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/secure_storage/secure_storage_service.dart';
import 'package:florista_ecommerce_app/features/log_out/data/data_sources/remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/log_out/data/models/message_response_model.dart';
import 'package:florista_ecommerce_app/features/log_out/domain/repo/repo_contract.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogOutRepoContract)
class RepoImpl implements LogOutRepoContract {
  final LogOutRemoteDataSourceContract remoteDataSource;
  final SecureStorageService secureStorageService;
  RepoImpl({
    required this.remoteDataSource,
    required this.secureStorageService,
  });
  @override
  Future<BaseResponse<String>> logOut() async {
    final response = await remoteDataSource.logOut();
    switch (response) {
      case SuccessBaseResponse<MessageResponseModel>(data: final data):
        secureStorageService.deleteAll();
        return SuccessBaseResponse<String>(
          data: data.message ?? S.current.logoutSuccessful,
        );
      case ErrorBaseResponse<MessageResponseModel>():
        return ErrorBaseResponse(
          errorMessage: response.errorMessage ?? S.current.logoutFailed,
        );
    }
  }
}
