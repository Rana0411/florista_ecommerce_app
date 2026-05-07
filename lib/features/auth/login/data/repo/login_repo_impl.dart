import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/secure_storage/secure_storage_service.dart';
import 'package:florista_ecommerce_app/core/app_keys/secure_storage_keys.dart';
import 'package:florista_ecommerce_app/features/auth/login/data/data_source/login_remote_data_source.dart';
import 'package:florista_ecommerce_app/features/auth/login/data/model/login_request_model.dart';
import 'package:florista_ecommerce_app/features/auth/login/domain/entity/login_entity.dart';
import 'package:florista_ecommerce_app/features/auth/login/domain/repo/login_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepo)
class LoginRepoImpl implements LoginRepo {
  final LoginRemoteDataSource _remoteDataSource;
  final SecureStorageService _secureStorage;

  const LoginRepoImpl(this._remoteDataSource, this._secureStorage);

  @override
  Future<BaseResponse<LoginEntity>> login({
    required String email,
    required String password,
  }) async {
    final result = await _remoteDataSource.login(
      LoginRequestModel(email: email, password: password),
    );

    return switch (result) {
      SuccessBaseResponse(:final data) => _persistToken(data.toEntity()),
      ErrorBaseResponse(:final error, :final errorMessage) =>
          ErrorBaseResponse(error: error, errorMessage: errorMessage),
    };
  }

  /// Persists the token via [SecureStorageService] using [SecureStorageKeys]
  /// — no raw string literals at the call site.
  Future<BaseResponse<LoginEntity>> _persistToken(LoginEntity entity) async {
    if (entity.token != null) {
      await _secureStorage.write(
        key: SecureStorageKeys.userToken,
        value: entity.token!,
      );
    }
    return SuccessBaseResponse(data: entity);
  }
}
